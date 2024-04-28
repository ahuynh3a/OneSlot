class EventsController < ApplicationController
  include CalendarOwnershipConcern
  before_action :set_calendar
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_is_owner_of_calendar, only: [:show, :destroy, :update, :edit]

  def index
    @events = @calendar.events
  end

  def show
  end
  def new

    @event = @calendar.events.new
  end

  def edit
  end

  def create
    @event = @calendar.events.build(event_params)
    if @event.save
      redirect_to calendar_event_path(@calendar, @event), notice: "Event was successfully."
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
    @calendar = Calendar.find(params[:calendar_id])
  end

  def set_event
    @event = @calendar.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :timezone, :location)
  end
end
