class API::PostsController < ApplicationController
    load_and_authorize_resource

    def index
        @posts = Post.all.order('created_at')
        render json: @posts
    end
end