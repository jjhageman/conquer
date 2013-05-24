class UserCoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @purchases = current_user.purchased_courses
    @preorders = current_user.preordered_courses
  end

  def show
    @course = current_user.purchased_courses.active.find(params[:id])
  end
end
