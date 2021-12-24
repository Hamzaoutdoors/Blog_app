class API::UsersController < ApplicationController
    load_and_authorize_resource
  
    def index
      @users = User.all
      render json: @users, status: :ok
    end
  
    def show
      @user = User.find(params[:id])
      render json: { success: true, data: { user: @user } }
    end
  end