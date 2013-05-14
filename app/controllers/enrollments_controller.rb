class EnrollmentsController < ApplicationController
  def new
    if @course = Course.find_by_id(params[:course_id])
      @enrollment = @course.enrollments.new
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end

  def show
  end
end
