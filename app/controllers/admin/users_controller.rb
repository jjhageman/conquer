module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
    end
  end
end
