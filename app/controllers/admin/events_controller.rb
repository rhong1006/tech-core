class Admin::EventsController < ApplicationController


  def index
    @events = Event.all
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:notice] = "Event saved"
    else
      flash[:alert] = "Event coult not be created"
    end
  end

  def destroy
    event = Event.find_by params[:event_id]
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
