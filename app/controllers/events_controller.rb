class EventsController < ApplicationController
  include CalendarOwnershipConcern
  before_action :set_calendar
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_event, only: [:show, :edit, :update, :destroy]  # Removed from :new and :create

  def index
    @events = @calendar.events
  end

  def show
  end

  def new
    @event = @calendar.events.new
    authorize @event 
  end

  def edit
  end

  def create
    @event = @calendar.events.build(event_params)
    authorize @event  # Ensure authorization with the fully built event
    if @event.save
      redirect_to calendar_event_path(@calendar, @event), notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to calendar_event_path(@calendar, @event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to user_url(username: current_user.username), notice: "Event was successfully destroyed."
  end

  private

  def set_calendar
    @calendar = Calendar.find_by(id: params[:calendar_id])
    unless @calendar
      redirect_to root_url, alert: "Calendar not found."
      return
    end
  end

  def set_event
    @event = @calendar.events.find_by(id: params[:id])
    unless @event
      redirect_to calendar_path(@calendar), alert: "Event not found."
      return
    end
  end

  def authorize_event
    authorize @event
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :timezone, :location)
  end
end
