class CommentsController < ApplicationController
  before_action :set_current_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(text: comment_params[:text], post_id: params[:post_id], author_id: current_user.id)

    if @comment.save
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]),
                  notice: 'Comment added successfully.'
    else
      render :new
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
