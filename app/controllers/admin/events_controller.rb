class Admin::EventsController < ApplicationController
  before_action :is_admin!

  def index
    @event = Event.new
    @events = Event.all
  end

  def create
    @event = Event.create event_params
    @event.save
    if @event.save
      redirect_to admin_events_path
      flash[:notice] = "Event saved"
    else
      flash[:alert] = "Event coult not be created"
    end
  end

  def destroy
    event = Event.find params[:id]
    event.destroy
    flash[:notice] = "Event deleted"
    redirect_to admin_events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :location, :start_time,
                                  :end_time, :organization_id)
  end

end
