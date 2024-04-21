class EventsController < ApplicationController
  before_action :set_calendar
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /calendars/:calendar_id/events
  def index
    @events = @calendar.events
  end

  # GET /calendars/:calendar_id/events/:id
  def show
  end

  # GET /calendars/:calendar_id/events/new
  def new
    @event = @calendar.events.new
  end

  # GET /calendars/:calendar_id/events/:id/edit
  def edit
  end

  # POST /calendars/:calendar_id/events
  def create
    @event = @calendar.events.build(event_params)
    if @event.save
      redirect_to calendar_event_path(@calendar, @event), notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calendars/:calendar_id/events/:id
  def update
    if @event.update(event_params)
      redirect_to calendar_event_path(@calendar, @event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /calendars/:calendar_id/events/:id
  def destroy
    @event.destroy
    redirect_to user_events_url(username: current_user.username), notice: "Event was successfully destroyed."
  end

  private

  def set_calendar
    @calendar = Calendar.find(params[:calendar_id])
  end

  def set_event
    @event = @calendar.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :timezone, :location)
  end
end
