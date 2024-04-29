class MembershipsController < ApplicationController
  before_action :set_group
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :authorize_membership, only:[:edit, :update, :destroy]

  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = @group.memberships.build
    authorize @membership
 
    @breadcrumbs = [
      {content: "Your Groups", href: user_groups_path(username: @group.owner.username)},
      {content: @group.name, href: group_path(@group)},
      {content: "New Membership", href: new_group_membership_path(@group)}
    ]

  end

  def edit
  end

  def create
    @membership = @group.memberships.find_or_initialize_by(user_id: membership_params[:user_id])
    authorize @membership

    respond_to do |format|
      if @membership.persisted?
        format.html { redirect_to group_path(@group), notice: "Member already exists in the group." }
        format.json { render json: { error: "Member already exists in the group" }, status: :unprocessable_entity }
      elsif @membership.save
        format.html { redirect_to group_path(@group), notice: "Membership was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
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

  def authorize_membership
    authorize @membership
  end

  def membership_params
    params.require(:membership).permit(:user_id)
  end
end
