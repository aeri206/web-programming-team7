class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
        @profile = current_user.profile 
        
        render 'index'
    end

end
