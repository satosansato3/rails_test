class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from SecurityError do |exception|
        redirect_to root_url, notice: "アクセス権がありません"
    end

    protected

    def authenticate_admin_user!
        raise SecurityError unless current_user.try(:admin?)
    end

    def configure_permitted_parameters
        added_attr = [:name, :email, :password, :password_confirmation, :remenber_me, :avatar]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attr
        devise_parameter_sanitizer.permit :account_update, keys: added_attr
    end
end
