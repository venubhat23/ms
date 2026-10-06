class PublicPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:adhika_privacy_policy, :adhika_account_deletion_policy, :marali_santhe_home]
  skip_load_and_authorize_resource
  layout 'public'

  def adhika_privacy_policy
    # This action renders the ADHIKA privacy policy page
    # No authentication required - public access
  end

  def adhika_account_deletion_policy
    # This action renders the ADHIKA account deletion policy page
    # No authentication required - public access
  end

  def marali_santhe_home
    # Serve the marali-santhe.html file directly
    html_content = File.read(Rails.root.join('public', 'marali-santhe.html'))
    render html: html_content.html_safe
  end
end