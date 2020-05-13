class HomeController < ApplicationController
    
    def index
        # if !user_signed_in?
        #     redirect_to 'users/sign_in'
        # end
        render 'landing_page'
    end
end
