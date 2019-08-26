class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  skip_authorization_check
end
