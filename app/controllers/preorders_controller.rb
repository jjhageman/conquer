class PreordersController < ApplicationController
  def show

  end

  def new
    if @course = Course.find_by_id(params[:id])
      #redirect_to user_course_path(@course) if @course.has_student?(current_user)
      @enrollment = @course.enrollments.new
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end

  def create

  end
end
