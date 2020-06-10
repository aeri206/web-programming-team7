class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
        @profile = current_user.profile
        @articles = current_user.profile.liked_articles.all
        @companies = current_user.profile.liked_companies.all
        render 'index'
    end

end
