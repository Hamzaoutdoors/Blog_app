class PostsController < ApplicationController
  def index
    @user = current_user
    @pagy, @posts = pagy(@user.posts, items: 3) if @user
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
    @post = Post.create(post_params)
    @post.author_id = current_user.id if current_user
    if @post.save
      flash[:success] = 'Article Successfully Created'
      redirect_back(fallback_location: root_path)
    else
      render 'new'
      flash[:info] = 'Create new post'
    end
  end

  def post_params
    params.require(:data).permit(:title, :text)
  end
end
