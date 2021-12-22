class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @post.comments.create(comment_params.merge(author_id: current_user.id))

    if @post.save
      flash[:success] = 'Comment Successfully Created'
    else
      flash[:danger] = 'Please add a valid comment'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_uri = request.env['PATH_INFO']
    @post = Post.find_by_id(params[:post_id])
    @user = User.find_by_id(@post.author_id)
    @comment = Comment.find_by_id(params[:id])

    if @comment.destroy
      flash[:success] = 'Comment Deleted Successfully'
      if current_uri.include?("/posts/#{@post.id}")
        redirect_to user_posts_path(@user.id)
      else
        redirect_back(fallback_location: root_path)
      end
    else
      flash.now[:danger] = 'You have not access'
    end
  end

  private

  def comment_params
    params.require(:data).permit(:text)
  end
end
