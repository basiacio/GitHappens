class DrillGroupsController < ApplicationController
  # before_action :authenticate_user! # for everything?
  before_action :find_drill_group, except: [:index, :new, :create]
  # before_action :authorize, except: [:index, :show]

  def index
    @drill_groups = DrillGroup.order created_at: :desc
  end

  def new
    @drill_group = DrillGroup.new
  end

  def create
    @drill_group      = DrillGroup.new
    # @drill_group.user = current_user

    if @drill_group.save
      redirect_to @drill_group, notice: 'Created New Drill Group!'
    else
      flash[:now] = 'Please fix the error below'
      render :new
    end

  end

  def show
    # @drill = Drill.new
    # 3.times { solution = @drill.solutions.build }
  end

  def edit
  end

  def update
    if @drill_group.update drill_group_params
      redirect_to @drill_group, notice: 'Drill Group changed!'
    else
      flash[:now] = 'Please fix the error below'
      render :edit
    end
  end

  def destroy
    @drill_group.destroy
    redirect_to drill_groups_path
  end

  private

  def find_drill_group
    @drill_group = DrillGroup.find params[:id]
  end

  def drill_group_params
    drill_group_params = params.require(:drill_group).permit(:name,
                                                             :description,
                                                             :level,
                                                             :points)
  end

  def authorize
    if cannot?(:manage, @drill_group)
      redirect_to root_path, alert: 'Not authorized.'
    end
  end
end
