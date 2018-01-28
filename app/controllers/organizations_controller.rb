class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    # Get params matching :organization
    organization_keyword = params[:organization]
    if organization_keyword
      # Get a type of keyword: search_name, tags_ids, tech_size
      keyword_type = organization_keyword.keys.first
      keyword = organization_keyword[keyword_type]
      if keyword_type  == "search_name"
        @organizations = Organization.search_by_name(keyword).order(name: :asc)
      elsif keyword_type == "tag_ids"
        @organizations = Organization.search_by_tag(keyword.map{|kw| kw if kw.present?})
      elsif keyword_type == "tech_size"
        @organizations = Organization.search_by_tech_size(keyword.to_i).order(name: :asc)
      end
    else
        @organizations = Organization.all.order(name: :asc);
    end

    # Send localizations for index page
    @isMarkersGood = true
    @markers = Gmaps4rails.build_markers(@organizations) do |organization, marker|
      # If some lat or long is nil, it will crashes the Maps on Index. The I send @isMarkersGood = false and donn't show the map... But I can use a lat / long fake here... just uncomment the code below
      if organization.latitude == nil || organization.longitude == nil
        # @isMarkersGood = false
        marker.lat 49.2780017  + (rand(1000) / 10000.0)
        marker.lng -123.1203521 + (rand(1000) / 10000.0)
        marker.infowindow "<a href='#{organization_path(organization.id)}'>#{organization.name}</a>"
      else
        marker.lat organization.latitude
        marker.lng organization.longitude
        marker.infowindow "<a href='#{organization_path(organization.id)}'>#{organization.name}</a>"
      end
    end

  end

  # GET /organizations/1
  def show
  end

  # GET /organizations/new
  def new
    if current_user.organizations.first.present?
      redirect_to home_path, alert: "You already have an organization."
    else
      @organization = Organization.new
    end
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  def create
    if current_user.organizations.first.present?
      head :unauthorized
    else
      @organization = Organization.new(organization_params)
      @organization.user = current_user
        if @organization.save
          redirect_to @organization, notice: 'Organization was successfully created.'
        else
          render :new
        end
    end
  end

  # PATCH/PUT /organizations/1
  def update
      if @organization.update(organization_params)
        redirect_to @organization, notice: 'Organization was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
      redirect_to organizations_url, notice: 'Organization was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
      if !@organization
        redirect_to home_path
      end
    end

    # Only permits parameters listed below
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
