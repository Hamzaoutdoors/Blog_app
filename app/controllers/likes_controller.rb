class LikesController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    @post.likes.create(author_id: current_user.id)
    flash[:success] = 'You liked the post ❤️'
    redirect_back(fallback_location: root_path)
  end
end
