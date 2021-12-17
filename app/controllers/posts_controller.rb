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
    @post = @user.posts.create(post_params.merge(author_id: current_user.id))
    @post.author_id = current_user.id if current_user
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
