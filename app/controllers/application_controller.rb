class ApplicationController < ActionController::Base
    def current_user
        User.take
    end
end
