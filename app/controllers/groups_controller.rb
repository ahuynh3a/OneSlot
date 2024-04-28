class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :ensure_current_user_is_owner, only: [:destroy, :update, :edit]

  def index
    @groups = Group.all
  end

  def show
    @events = @group.member_events
    @schedule_analyzer = ScheduleAnalyzer.new(@events)
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user unless @group.user_ids.include?(current_user.id)
    @group.owner = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to user_groups_path(username: current_user.username), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to user_groups_path(username: current_user.username), notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_current_user_is_owner
    if current_user != @group.owner
      redirect_back fallback_location: root_url, alert: "You do not have permission to modify this group. Please contact the owner if you believe this is an error."
    end
  end

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end
end
