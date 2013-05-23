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
    debugger
    @enrollment = Enrollment.new(params[:enrollment])
    @enrollment.user = current_user
    @enrollment.purchased = true
    if @enrollment.save_and_make_payment
      redirect_to user_course_path(@enrollment.course), notice: "Thank you for enrolling!"
    else
      @course = @enrollment.course
      render :new
    end
  end
end
