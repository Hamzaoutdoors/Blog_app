class ApipostsController < ApplicationController
    def index
        @posts = Post.all 
        render json: @posts, response: response
    end
end