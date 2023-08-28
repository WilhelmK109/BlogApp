class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: :comments).find(params[:id])
    @posts = @user.three_most_recent_posts
  end
end
