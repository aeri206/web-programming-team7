class ProfileController < ApplicationController
    def index
        # @profile = Profile[:id] # 이런 식으로 user id에 대응하는 Profile 가져오기
        render 'index'
    end

    def edit
        # render 'edit'

        profile_id = params[:id]
        profile = Profile(profile_id) # 확인 필요 

        nickname = params[:nickname]
        info = params[:info]

        profile.nickname = nickname
        profile.info = info
        profile.sve

        redirect_to action: 'index'
    end

    def update
        redirect_to action: 'index'
    end
end
