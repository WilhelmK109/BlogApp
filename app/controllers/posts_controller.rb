class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.all
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      format.html do
        if @post.save
          redirect_to user_post_path(current_user, @post), notice: 'Post created successfully.'
        else
          render :new
        end
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
    @current_user = current_user
    @like = Like.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
