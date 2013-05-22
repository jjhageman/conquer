class UserCoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @courses = current_user.courses
  end

  def show
    @course = current_user.courses.find(params[:id])
  end
end
