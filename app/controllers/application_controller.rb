class ApplicationController < ActionController::Base
    # include Devise::Controllers::Helpers
    include ApplicationHelper
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    helper_method :current_user

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[fname lname])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[fname lname])
    end

    def after_sign_out_path_for(resource_or_scope)
      users_path
    end
    def after_sign_in_path_for(resource_or_scope)
      users_path
    end
end