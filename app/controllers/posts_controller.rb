class PostsController < ApplicationController
  load_and_authorize_resource

  # skip_authorize_resource only: [:all_posts]

  def index
    @current_user = current_user
    @user = User.find_by_id(params[:user_id])
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
    current_uri = request.env['PATH_INFO']
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])

    if @post.destroy
      flash[:success] = 'Post Deleted Successfully'
      if current_uri.include?("/posts/#{params[:id]}")
        redirect_to user_posts_path(@user.id)
      else
        redirect_back(fallback_location: root_path)
      end
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
