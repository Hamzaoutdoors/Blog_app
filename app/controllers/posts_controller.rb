class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.where(author_id: @user.id).order(:id)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @comments = Comment.where(post_id: @post.id)
  end

  def create
    @post = Post.create(post_params)
    @post.update_comments_counter
    @post.update_likes_counter
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter, :author_id)
  end
end
