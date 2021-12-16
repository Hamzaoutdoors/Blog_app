class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.where(author_id: @user.id).order(:id)
    @pagy, @all_posts = pagy(@posts, items: 2) if @user
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
    @post = Post.new
    @post.author_id = current_user.id if current_user
    @post.title = params[:title]
    @post.text = params[:text]
    if @post.save
      flash[:success] = 'Article Successfully Created'
      redirect_back(fallback_location: root_path)
    else
      render 'new'
      flash[:info] = 'Create new post'
    end
  end
end
