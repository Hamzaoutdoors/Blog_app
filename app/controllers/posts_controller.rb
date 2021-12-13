class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = Post.where(author_id: @user.id).order(:id)

  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @comments = Comment.where(post_id: @post.id)
  end
end
