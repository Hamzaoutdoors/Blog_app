class CommentsController < ApplicationController
  def create
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end
end
