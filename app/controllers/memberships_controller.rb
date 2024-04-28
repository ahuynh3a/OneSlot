class MembershipsController < ApplicationController
  before_action :set_group, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_is_group_owner, only: [:new, :create, :edit, :update]
  before_action :ensure_current_user_is__group_owner_or_self, only: [:destroy]

  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = @group.memberships.build
  end

  def edit
  end

  def create
    existing_membership = @group.memberships.find_by(user_id: membership_params[:user_id])
    respond_to do |format|
      if existing_membership
        format.html { redirect_to group_path(@group), notice: "Member already exists in the group." }
        format.json { render json: { error: "Member already exists in the group" }, status: :unprocessable_entity }
      else
        @membership = @group.memberships.build(membership_params)
        if @membership.save
          format.html { redirect_to group_path(@group), notice: "Membership was successfully created." }
          format.json { render :show, status: :created, location: @membership }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @membership.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to [@group, @membership], notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership = @group.memberships.find_by(user_id: current_user.id)

    return redirect_not_member unless @membership

    if @membership.destroy
      redirect_to user_groups_path(current_user.username), notice: "You have successfully left the group."
    else
      respond_to do |format|
        format.html { redirect_to group_path(@group), alert: "Failed to leave the group." }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_membership
    @membership = @group.memberships.find(params[:id])
  end

  def ensure_current_user_is_group_owner
    unless current_user == @group.owner
      redirect_back fallback_location: root_url, alert: "Only the group owner can manage memberships."
    end
  end

  def ensure_current_user_is__group_owner_or_self
    unless current_user == @group.owner || current_user == @membership.user
      redirect_back fallback_location: root_url, alert: "You do not have permission to remove this membership unless it is your own."
    end
  end

  def membership_params
    params.require(:membership).permit(:user_id)
  end
end
