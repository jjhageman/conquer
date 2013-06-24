module Admin
  class BaseController < ApplicationController
    before_filter  :authenticate_user!, :verify_admin
    
    private
    def verify_admin
      redirect_to root_url, :alert => "You are not authorized this page." unless current_user && current_user.admin?
    end
  end
end
