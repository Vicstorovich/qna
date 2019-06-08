class ApplicationController < ActionController::Base
  def per_page(resource, num)
    resource.all.page(params[:page]).per(num)
  end
end
