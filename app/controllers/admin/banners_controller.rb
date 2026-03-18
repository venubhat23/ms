class Admin::BannersController < Admin::ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy, :toggle_status]

  # GET /admin/banners
  def index
    @banners = Banner.includes(banner_image_attachment: :blob)
                    .order(:display_order, :created_at)
                    .page(params[:page]).per(25)

    # Filter by status if specified
    case params[:status]
    when 'active'
      @banners = @banners.active
    when 'inactive'
      @banners = @banners.inactive
    when 'current'
      @banners = @banners.current
    end

    # Filter by location if specified
    if params[:location].present?
      @banners = @banners.by_location(params[:location])
    end

    # Statistics for dashboard cards
    @stats = {
      total_banners: Banner.count,
      active_banners: Banner.active.count,
      current_banners: Banner.current.count,
      expired_banners: Banner.where('display_end_date < ?', Date.current).count
    }
  end

  # GET /admin/banners/1
  def show
  end

  # GET /admin/banners/new
  def new
    @banner = Banner.new
    @banner.display_start_date = Date.current
    @banner.display_end_date = 1.month.from_now
    @banner.display_order = (Banner.maximum(:display_order) || 0) + 1
  end

  # GET /admin/banners/1/edit
  def edit
  end

  # POST /admin/banners
  def create
    @banner = Banner.new(banner_params)

    if @banner.save
      redirect_to admin_banner_path(@banner), notice: 'Banner was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/banners/1
  def update
    if @banner.update(banner_params)
      redirect_to admin_banner_path(@banner), notice: 'Banner was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/banners/1
  def destroy
    @banner.destroy
    redirect_to admin_banners_path, notice: 'Banner was successfully deleted.'
  end

  # PATCH /admin/banners/1/toggle_status
  def toggle_status
    @banner.update(status: !@banner.status)
    status_text = @banner.status? ? 'activated' : 'deactivated'
    redirect_to admin_banners_path, notice: "Banner was successfully #{status_text}."
  end

  # POST /admin/banners/upload_cloudinary_image
  def upload_cloudinary_image
    Rails.logger.info "=== BANNER CLOUDINARY UPLOAD START ==="
    Rails.logger.info "Params received: #{params.inspect}"
    Rails.logger.info "Image param present: #{params[:image].present?}"
    Rails.logger.info "Image param class: #{params[:image].class}" if params[:image].present?

    respond_to do |format|
      if params[:image].present?
        begin
          Rails.logger.info "Starting Cloudinary upload..."

          result = Cloudinary::Uploader.upload(
            params[:image].tempfile,
            folder: 'banners',
            public_id: "banner-temp-#{SecureRandom.hex(8)}",
            overwrite: true,
            resource_type: :auto,
            transformation: [
              { width: 1200, height: 600, crop: :limit, quality: :auto, fetch_format: :auto }
            ]
          )

          Rails.logger.info "Cloudinary upload successful: #{result.inspect}"

          format.json {
            render json: {
              success: true,
              public_id: result['public_id'],
              url: result['secure_url'],
              thumbnail_url: Cloudinary::Utils.cloudinary_url(result['public_id'], width: 300, height: 150, crop: :fill)
            }
          }
        rescue => e
          Rails.logger.error "Cloudinary upload error: #{e.message}"
          Rails.logger.error "Error backtrace: #{e.backtrace.first(5).join('\n')}"

          format.json {
            render json: { success: false, error: "Upload failed: #{e.message}" }, status: :unprocessable_entity
          }
        end
      else
        Rails.logger.error "No image file provided"
        format.json {
          render json: { success: false, error: "No image file provided" }, status: :bad_request
        }
      end
    end
  end

  # POST /admin/banners/upload_r2_image
  def upload_r2_image
    respond_to do |format|
      if params[:image].present?
        begin
          Rails.logger.info "🔄 Starting R2 upload for banner image: #{params[:image].original_filename}"
          Rails.logger.info "📁 File size: #{params[:image].size} bytes"
          Rails.logger.info "🎯 Content type: #{params[:image].content_type}"

          # Upload to R2
          result = R2Service.upload(params[:image], folder: 'banners')

          if result[:error]
            Rails.logger.error "❌ R2 upload failed: #{result[:error]}"
            format.json { render json: { error: result[:error] }, status: :unprocessable_entity }
          else
            Rails.logger.info "✅ R2 upload successful: #{result[:key]}"
            format.json { render json: {
              key: result[:key],
              filename: result[:filename],
              public_url: result[:public_url],
              size: result[:size]
            }}
          end

        rescue => e
          Rails.logger.error "💥 R2 upload exception: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          format.json { render json: { error: "Upload failed: #{e.message}" }, status: :internal_server_error }
        end
      else
        Rails.logger.warn "⚠️ No image provided in R2 upload request"
        format.json { render json: { error: "No image provided" }, status: :bad_request }
      end
    end
  end

  def delete_r2_image
    respond_to do |format|
      image_url = params[:image_url]
      delete_from_storage = params[:permanent] == 'true'

      if image_url.blank?
        format.json { render json: { error: "Image URL is required" }, status: :bad_request }
        return
      end

      begin
        Rails.logger.info "🗑️ Starting R2 banner image deletion for URL: #{image_url}"

        if delete_from_storage
          key = extract_r2_key_from_url(image_url)
          if key
            success = R2Service.delete(key)
            if success
              format.json { render json: {
                success: true,
                message: "Banner image permanently deleted from R2 storage",
                deleted_from_storage: true
              }}
            else
              format.json { render json: {
                success: true,
                message: "Banner image unlinked (R2 deletion failed)",
                deleted_from_storage: false
              }}
            end
          else
            format.json { render json: {
              success: true,
              message: "Banner image unlinked (could not delete from storage)",
              deleted_from_storage: false
            }}
          end
        else
          format.json { render json: {
            success: true,
            message: "Banner image unlinked",
            deleted_from_storage: false
          }}
        end

      rescue => e
        Rails.logger.error "💥 R2 banner image deletion exception: #{e.message}"
        format.json { render json: { error: "Deletion failed: #{e.message}" }, status: :internal_server_error }
      end
    end
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  end

  def extract_r2_key_from_url(image_url)
    begin
      uri = URI.parse(image_url)
      key = uri.path[1..-1] if uri.path
      Rails.logger.info "🔍 Extracted key from banner URL: #{image_url} -> #{key}"
      key
    rescue => e
      Rails.logger.error "❌ Failed to parse banner URL: #{image_url} - #{e.message}"
      nil
    end
  end

  def banner_params
    params.require(:banner).permit(
      :title, :description, :redirect_link, :display_start_date, :display_end_date,
      :display_location, :status, :display_order, :banner_image, :image_url, :r2_image_url
    )
  end
end