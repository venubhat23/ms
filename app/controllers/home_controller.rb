class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  skip_before_action :set_cache_control_headers
  skip_before_action :ensure_session_security

  def index
    Rails.logger.info "HomeController#index called - serving marali-santhe.html"

    # Serve the marali-santhe.html file directly without any layout
    html_content = File.read(Rails.root.join('public', 'marali-santhe.html'))
    render html: html_content.html_safe, layout: false
  end
end