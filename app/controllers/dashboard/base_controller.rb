class Dashboard::BaseController < ApplicationController
  before_action :authenticate_user!, :verify_mentor

  private

  def verify_mentor
    render file: "public/422.html" unless current_user.has_role?(:mentor)
  end
end
