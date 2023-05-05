class UsersController < ApplicationController
  # before_action :correct_user, onyl:[:edit, :update]

  def index
    @users = User.page(params[:page])
    @task = Task.new
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(task_params)
    redirect_to user_path(@user.id)
  end

  private

  def task_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  # def correct_user
  #   @task = Task.find(params[:id])
  #   @user = @task.user
  #   redirect_to(tasks_path) unless @user == current_user
  # end

end
