class EnrollmentsController < ApplicationController
  before_filter :redirect_after_authentication, only: :new
  before_filter :authenticate_user!

  def show
    @enrollment = current_user.enrollments.find(params[:id])
    @course = @enrollment.course
  end

  def new
    if @course = Course.find_by_id(params[:course_id])
      redirect_to user_course_path(@course) if @course.has_student?(current_user)
      @enrollment = @course.enrollments.new
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end

  def create
    @enrollment = Enrollment.new(params[:enrollment])
    @enrollment.user = current_user
    @enrollment.purchased = true
    if @enrollment.save_and_make_payment
      redirect_to enrollment_path(@enrollment), notice: "Thank you for enrolling!"
    else
      @course = @enrollment.course
      render :new
    end
  end

  private
  
  def redirect_after_authentication
    unless user_signed_in?
      session[:enrollment_url] = request.fullpath
      redirect_to new_user_registration_path
    end
  end
end
