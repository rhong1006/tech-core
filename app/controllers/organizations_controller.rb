class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    organization_keyword = params[:organization]
    if organization_keyword
      keyword_type = organization_keyword.keys.first
      keyword = organization_keyword[keyword_type]
      if keyword_type  == "search_name"
        @organizations = Organization.search_by_name(keyword)
      elsif keyword_type == "tag_ids"
        @organizations = Organization.search_by_tag(keyword.map{|kw| kw if kw.present?})
      elsif keyword_type == "tech_size"
        @organizations = Organization.search_by_tech_size(keyword.to_i)
      end
    else
        @organizations = Organization.all
    end

    # send localizations fot index page
    @markers = Gmaps4rails.build_markers(@organizations) do |organization, marker|
      marker.lat organization.latitude
      marker.lng organization.longitude
      marker.infowindow "<a href='#{organization_path(organization.id)}'>#{organization.name}</a>"
    end

  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.user = current_user

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        # format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        # format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      if @organization
        @organization = Organization.find(params[:id])
      else
        redirect_to home_path
      end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:search_name, :name, :address, :latitude, :longitude, :overview, :employees, :tech_team_size, :website, :twitter, :logo, :published)
    end

    def authorize_user!
      unless can?(:crud, @organization)
        flash[:alert] = "Access Denied!"
        redirect_to home_path
      end
    end
end
