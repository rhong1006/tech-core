class Admin::OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def create
    @organization = Organization.new organization_params
    if @organization.save
      flash[:notice] = "Organization saved"
    else
      flash[:alert] = "Organization coult not be created"
    end
  end

  def destroy
    organization = Organization.find_by params[:id]
    organization.destroy
    flash[:notice] = "Organization deleted"
    redirect_to admin_organizations_path
  end

  private
  def organization_params
    params.require(:organization).permit(:title, :description, :location, :start_time
                                  :end_time, :organization_id, :published)
  end

end
