class AdminController < ApplicationController
  before_action :is_admin!

  def index
    redirect_to admin_organizations_path
  end
end
