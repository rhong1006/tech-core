class Admin::OrganizationsController < ApplicationController
  before_action :is_admin!

  def index
    @organization = Organization.create
    @organizations = Organization.order(created_at: :desc)
  end

  def create
    @organization = Organization.create organization_params
    @organization.user_id = current_user.id
    @organization.save
    if @organization.save
      redirect_to admin_organizations_path
      flash[:notice] = "Organization saved"
    else
      flash[:alert] = "Organization coult not be created"
    end
  end

  def destroy
    organization = Organization.find params[:id]
    organization.destroy
    flash[:notice] = "Organization deleted"
    redirect_to admin_organizations_path
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :address, :overview, :employees,
                                  :tech_team_size, :website, :twitter, :logo,
                                  :published, :user_id, :user)
  end

end
 
