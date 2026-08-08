class Api::V1::Admin::BannersController < Api::V1::Admin::BaseController
  # GET /api/v1/admin/banners
  def index
    banners = Banner.order(:display_order, :created_at)
    banners = banners.where(display_location: params[:location]) if params[:location].present?
    banners = banners.where(status: params[:status] == 'active') if params[:status].in?(%w[active inactive])

    page = params[:page] || 1
    per_page = params[:per_page] || 20
    banners = banners.page(page).per(per_page)

    render_success(
      banners: banners.map { |b| banner_response(b) },
      pagination: {
        current_page: banners.current_page,
        total_pages: banners.total_pages,
        total_count: banners.total_count,
        per_page: banners.limit_value
      }
    )
  end

  # POST /api/v1/admin/banners
  # Accepts either an uploaded `image` file (goes to R2) or a pre-hosted `image_url`/`r2_image_url`.
  def create
    banner = Banner.new(banner_params)

    if params[:image].present?
      result = R2Service.upload(params[:image], folder: 'banners')
      return render_error("Upload failed: #{result[:error]}", nil, :unprocessable_entity) if result[:error]
      banner.r2_image_url = result[:public_url]
    end

    if banner.save
      render_success(banner_response(banner), 'Banner created successfully', :created)
    else
      render_validation_errors(banner)
    end
  end

  private

  def banner_params
    params.permit(
      :title, :description, :redirect_link, :display_start_date, :display_end_date,
      :display_location, :status, :display_order, :image_url, :r2_image_url
    )
  end

  def banner_response(banner)
    {
      id: banner.id,
      title: banner.title,
      description: banner.description,
      redirect_link: banner.redirect_link,
      display_location: banner.display_location,
      display_start_date: banner.display_start_date,
      display_end_date: banner.display_end_date,
      display_order: banner.display_order,
      status: banner.status,
      image_url: banner.r2_image_url.presence || banner.image_url,
      created_at: banner.created_at
    }
  end
end
