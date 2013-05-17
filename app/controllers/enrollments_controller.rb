class EnrollmentsController < ApplicationController
  before_filter :require_login

  def new
    if @course = Course.find_by_id(params[:course_id])
      @enrollment = @course.enrollments.new
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end

  def create
    @enrollment = Enrollment.new(params[:enrollment])
    @enrollment.user = current_user
    if @enrollment.save_and_make_payment
      redirect_to @enrollment, notice: "Thank you for enrolling"
    else
      render :new
    end
  end

  def show
  end

  private
  
  def require_login
    unless user_signed_in?
      session[:enrollment_url] = request.fullpath
      redirect_to new_user_registration_path
    end
  end
end
