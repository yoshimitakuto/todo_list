class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = current_user.comments.new(comment_params)
    @comment.task_id = @task.id
    if @comment.save
      flash[:notice] = 'コメント投稿できました'
      # redirect_back fallback_location: root_path
    else
      flash[:notice] = 'コメント投稿に失敗しました'
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    # redirect_back fallback_location: root_path
    @task = Task.find(params[:task_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
