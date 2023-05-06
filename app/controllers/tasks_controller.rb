class TasksController < ApplicationController
  before_action :params_find, only: [:show, :edit, :update]
  # before_action :set_q, only: [:index, :search]

  def search
    @q = Task.ransack(params[:q])
    @results = @q.result
  end

  def index
    @q = Task.ransack(params[:q])
    @tasks = Task.all.page(params[:page]).order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "投稿が成功しました"
      redirect_to tasks_path
    else
      flash[:notice] = "投稿に失敗しました"
      @tasks = Task.page(params[:page])
      render :index
    end
  end

  def show
    @task_new = Task.new
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @task.update(task_params)
     flash[:notice] = "更新に成功しました"
     redirect_to task_path(@task.id)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  private

  # def set_q
  #   @q = Task.ransack(params[:q])
  # end

  def task_params
    params.require(:task).permit(:title, :body, :image)
  end

  def params_find
    @task = Task.find(params[:id])
  end

end
