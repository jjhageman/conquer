module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end
    
    def show
      @user = User.includes(enrollments: [:course, :promotion]).find(params[:id])
    end

    def new
      @user = User.new
    end
  end
end
