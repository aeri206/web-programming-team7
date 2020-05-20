class ApplicationController < ActionController::Base
    # before_action :configure_permitted_parameters, if: :devise_controller?
 
    # protected

<<<<<<< HEAD
    # originally commented out
=======
    # originally commented out (수정)
>>>>>>> my page entry
    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:first_name, :last_name, :email, :password, :password_confirmation])
    # end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    end

    before_action :store_user_location!, if: :storable_location?
    # before_action :authenticate_user! # 로그인한 유저만 볼 수 있음. 랜딩 페이지가 자동으로 로그인으로 들어감 

    private
    
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    # 로그아웃 후 redirect인데 작동 안하는 듯 (현재 routes의 root directory 이용해서 돌아감)
    def after_sign_in_path_for(resource_or_scope) 
      stored_location_for(resource_or_scope) || super
    end

end
