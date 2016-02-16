class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :admin_vars

    def admin_vars
        @admin_signed_up = Admin.all.count>0
    end
  

end
