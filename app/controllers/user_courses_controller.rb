class UserCoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @courses = current_user.courses
    @preorders = current_user.preorders
  end

  def show
    @course = current_user.courses.includes(:forums).find_by_url(params[:id])
    @forums = @course.forums
    @rating = CourseRating.new(course: @course, user: current_user).stars_by_user_or_average
  end
end
