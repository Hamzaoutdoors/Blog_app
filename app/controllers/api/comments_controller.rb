class API::CommentsController < ApplicationController
    load_and_authorize_resource

    def index
        @comments = Comment.where(post_id: params[:post_id]).order(:created_at)
        render json: @comments
    end

    def create
        @post = Post.find_by_id(params[:post_id])
        @comment = Comment.new(comment_params.merge(author_id: current_user.id, post_id: @post.id))
    
        if @comment.save
           render json: @comment, status: :created
        else
          render json: {error: "Unable to create a Comment for this post"}, stats: 400
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:text)
    end
end
