class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = current_user
    @pagy, @posts = pagy(@user.posts.includes(:comments), items: 2) if @user
  end

  def show
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(@post.author_id)
    @comments = Comment.includes(:post).where(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      flash[:success] = 'Post Successfully Destroyed the post'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'You have not access'
    end
  end

  def create
    @post = Post.new(post_params.merge(author_id: current_user.id))
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:success] = 'Post Successfully Created'
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      flash.now[:danger] = 'Form contains errors. Please see fields marked in red'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
