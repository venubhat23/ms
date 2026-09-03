class Admin::ProductSummaryController < Admin::ApplicationController
  before_action :authenticate_user!

  TABS = %w[main franchises stores].freeze

  # Read-only inventory summary with three views:
  #   main       – central/HQ warehouse stock for every product & variant
  #   franchises – on-hand quantity per active franchise (product level)
  #   stores     – on-hand quantity per active physical store (product + variant)
  #
  # Franchise / store views switch layout on the number of entities shown:
  # up to 2 -> one combined matrix (entities as columns); more -> one card
  # per entity.
  def index
    @tab = TABS.include?(params[:tab]) ? params[:tab] : "main"

    @tab_counts = {
      "main"       => Product.count,
      "franchises" => Franchise.active.count,
      "stores"     => Store.active.where(is_main_inventory: [false, nil]).count
    }

    case @tab
    when "main"       then load_main
    when "franchises" then load_franchises
    when "stores"     then load_stores
    end
  end

  private

  DEFAULT_THRESHOLD = 10

  # ---- main / HQ warehouse ------------------------------------------------

  def load_main
    products = Product.includes(:product_variants, :category).order(:name).to_a

    @rows = products.map { |product| build_main_row(product) }

    @stats = {
      products: products.size,
      variants: products.sum { |p| p.product_variants.size },
      units:    @rows.sum { |r| r[:stock] },
      low:      @rows.count { |r| r[:status] == :low },
      out:      @rows.count { |r| r[:status] == :out }
    }
  end

  def build_main_row(product)
    variants = product.sorted_variants.map do |variant|
      stock = variant.available_stock.to_f
      thr   = variant.low_stock_threshold.to_f
      { variant: variant, label: variant.label, stock: stock,
        threshold: variant.low_stock_threshold, status: stock_status(stock, thr) }
    end

    if product.has_multiple_quantities?
      total = variants.sum { |v| v[:stock] }
      thr   = product.minimum_stock_alert.to_f
      status = if total <= 0 then :out
               elsif variants.any? { |v| v[:status] != :ok } || (thr.positive? && total <= thr) then :low
               else :ok
               end
    else
      total  = product.stock.to_f
      thr    = product.minimum_stock_alert.to_f
      status = stock_status(total, thr)
    end

    { product: product, category: product.category&.name, sku: product.sku,
      stock: total, threshold: product.minimum_stock_alert, status: status,
      variants: variants }
  end

  # ---- franchises -------------------------------------------------------

  def load_franchises
    @franchises = Franchise.active.order(:name).to_a
    rows = FranchiseInventory.where(franchise_id: @franchises.map(&:id)).includes(:product).to_a

    qty = Hash.new(0.0)  # [franchise_id, product_id] => quantity
    product_ids = []
    rows.each do |r|
      qty[[r.franchise_id, r.product_id]] += r.quantity.to_f
      product_ids << r.product_id
    end

    products = Product.where(id: product_ids.uniq).includes(:category).order(:name).to_a

    lines = products.map do |product|
      thr = franchise_threshold(product)
      { id: "p#{product.id}", label: product.name, sub: false,
        meta: [product.category&.name, product.sku].compact.join(" · "), threshold: thr }
    end

    build_matrix(
      entities: @franchises.map { |f| { id: f.id, name: f.name, active: f.active?, sub: f.city } },
      lines: lines,
      quantity: ->(entity_id, line) {
        product_id = line[:id].delete_prefix("p").to_i
        qty.key?([entity_id, product_id]) ? qty[[entity_id, product_id]] : nil
      }
    )

    @unit_word = "franchise"
  end

  def franchise_threshold(product)
    product.minimum_stock_alert.to_i.positive? ? product.minimum_stock_alert.to_i : DEFAULT_THRESHOLD
  end

  # ---- stores ---------------------------------------------------------

  def load_stores
    @stores = Store.active.where(is_main_inventory: [false, nil]).order(:name).to_a
    rows = StoreInventory.where(store_id: @stores.map(&:id))
                         .includes(:product, :product_variant).to_a

    qty = {}  # [store_id, product_id, variant_id] => quantity
    thr = {}  # [product_id, variant_id] => threshold (last one wins; fine for display)
    product_ids = []
    rows.each do |r|
      qty[[r.store_id, r.product_id, r.product_variant_id]] = r.quantity.to_f
      thr[[r.product_id, r.product_variant_id]] = r.low_stock_threshold.to_i
      product_ids << r.product_id
    end

    products = Product.where(id: product_ids.uniq).includes(:product_variants, :category).order(:name).to_a

    lines = []
    products.each do |product|
      meta = [product.category&.name, product.sku].compact.join(" · ")
      variant_ids_present = rows.select { |r| r.product_id == product.id && r.product_variant_id }
                                .map(&:product_variant_id).uniq

      if variant_ids_present.any?
        # Roll-up header row + one indented row per stocked variant.
        lines << { id: "p#{product.id}", label: product.name, sub: false,
                   meta: meta, threshold: nil, header: true }
        product.sorted_variants.each do |variant|
          next unless variant_ids_present.include?(variant.id)
          lines << { id: "p#{product.id}v#{variant.id}", label: variant.label, sub: true,
                     meta: nil, threshold: thr[[product.id, variant.id]] || DEFAULT_THRESHOLD }
        end
      else
        lines << { id: "p#{product.id}", label: product.name, sub: false,
                   meta: meta, threshold: thr[[product.id, nil]] || DEFAULT_THRESHOLD }
      end
    end

    build_matrix(
      entities: @stores.map { |s| { id: s.id, name: s.name, active: s.status, sub: s.city } },
      lines: lines,
      quantity: ->(entity_id, line) {
        pid, vid = parse_line_id(line[:id])
        if line[:header]
          keys = qty.keys.select { |sid, p, _v| sid == entity_id && p == pid }
          keys.empty? ? nil : keys.sum { |k| qty[k] }
        else
          qty.key?([entity_id, pid, vid]) ? qty[[entity_id, pid, vid]] : nil
        end
      }
    )

    @unit_word = "store"
  end

  def parse_line_id(id)
    m = id.match(/\Ap(\d+)(?:v(\d+))?\z/)
    [m[1].to_i, m[2]&.to_i]
  end

  # ---- shared matrix builder -----------------------------------------

  # Produces @matrix consumed by the franchise / store views.
  def build_matrix(entities:, lines:, quantity:)
    cells = {}         # [entity_id, line_id] => { qty:, status: }
    line_totals = Hash.new(0.0)
    entity_totals = Hash.new(0.0)

    entities.each do |entity|
      lines.each do |line|
        q = quantity.call(entity[:id], line)
        next if q.nil?

        status = line[:header] ? nil : stock_status(q, line[:threshold].to_f)
        cells[[entity[:id], line[:id]]] = { qty: q, status: status }
        unless line[:header]
          line_totals[line[:id]] += q
          entity_totals[entity[:id]] += q
        end
      end
    end

    @matrix = {
      layout: entities.size <= 2 ? :combined : :cards,
      entities: entities,
      lines: lines,
      cells: cells,
      line_totals: line_totals,
      entity_totals: entity_totals,
      low: cells.values.count { |c| c[:status] == :low },
      out: cells.values.count { |c| c[:status] == :out },
      units: entity_totals.values.sum
    }
  end

  def stock_status(stock, threshold)
    return :out if stock <= 0
    return :low if threshold.positive? && stock <= threshold
    :ok
  end
end
