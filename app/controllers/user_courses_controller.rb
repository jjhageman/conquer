class UserCoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @courses = current_user.courses
    @preorders = current_user.preorders
  end

  def show
    @course = current_user.courses.find_by_url(params[:id])
    @rating = Rating.where(user_id: current_user, course_id: @course).first_or_initialize
  end
end
