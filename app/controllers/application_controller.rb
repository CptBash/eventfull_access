class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def index
        @permissions = Permission.get_user_permissions(current_user.id)
    end

end
