class LikesController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    if @like.save
      flash[:success] = 'You liked the post ❤️'
    else
      flash[:danger] = 'Error: There is some error here'
    end
    redirect_back(fallback_location: root_path)
  end
end
