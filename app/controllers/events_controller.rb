class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all.order(start_time: :asc)
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    if !current_user.organizations.present?
     redirect_to new_organization_path,
                   alert: 'Must belong to an organization to create an event'
   else
     @event = Event.new
   end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new event_params
    @event.organization = current_user.organizations.first
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy

    respond_to do |format|
      # redirect to my organization show page
      format.html { redirect_to organization_url(current_user.organizations.first), notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    begin
      @event = Event.find params[:id]
    rescue
      redirect_to events_path
    end
  end

  # Only permits parameters listed below
  def event_params
    params.require(:event).permit(:title, :description, :location, :start_time, :end_time)
  end

  def authorize_user!
    unless can?(:crud, @event)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
