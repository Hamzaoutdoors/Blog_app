class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:user).where(author_id: @user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Signed in successfully'
      redirect_to user_post_path(@post.author_id, @post.id)
      redirect_to @user
    end
  end

  def edit
    current_user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :photo, :posts_counter, :email, :password)
  end

  def display_error_message
    flash.now[:danger] = 'Form contains errors. Please see fields marked in red'
  end
end
