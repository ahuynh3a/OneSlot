class CalendarsController < ApplicationController
  include CalendarOwnershipConcern
  before_action :set_calendar, only: %i[ show edit update destroy ]
  before_action :ensure_current_user_is_owner_of_calendar, only: [:destroy, :update, :edit]

  def index
    @calendars = Calendar.all
  end

  def show
  end

  def new
    @calendar = Calendar.new
  end

  def edit
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.owner = current_user

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully created." }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url, notice: "Calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  def calendar_params
    params.require(:calendar).permit(:owner_id, :title, :description)
  end
end
