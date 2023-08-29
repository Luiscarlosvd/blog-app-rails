class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      flash.now[:error] = 'Failed to create the post.'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
