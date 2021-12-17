class PostsController < ApplicationController
  def index
    @user = current_user
    @pagy, @posts = pagy(@user.posts, items: 2) if @user
  end

  def show
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(@post.author_id)
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.author_id = @user ? @user.id : params[:user_id]
    if @post.save
      flash[:success] = 'Post Successfully Created'
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      flash[:notice] = 'Form contains errors. Please see fields marked in red'
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
