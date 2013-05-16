class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    session[:enrollment_url] || user_root_path
  end
end
