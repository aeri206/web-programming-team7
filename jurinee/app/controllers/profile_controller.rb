class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
        @profile = current_user.profile # 현재 login한 user 기준  
        # @profile = Profile.find(params[:id])
        render 'index'
    end

    # def edit
    #     render 'edit'

    #     profile_id = params[:id]
    #     profile = Profile(profile_id) # 확인 필요 

    #     nickname = params[:nickname]
    #     info = params[:info]

    #     profile.nickname = nickname
    #     profile.info = info
    #     profile.save

    #     redirect_to action: 'index'
    # end

    # def update
    #     redirect_to action: 'index'
    # end
end
