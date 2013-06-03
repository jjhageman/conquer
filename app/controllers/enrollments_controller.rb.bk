class EnrollmentsController < ApplicationController
  before_filter :authentication_redirect, only: :new
  before_filter :load_course, only: :new
  before_filter :authenticate_user!

  def show
    @enrollment = current_user.enrollments.find(params[:id])
    @course = @enrollment.course
  end

  def new
    @enrollment = @course.enrollments.new
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
  
  def authentication_redirect
    unless user_signed_in?
      session[:enrollment_url] = request.fullpath
      redirect_to new_user_registration_path
    end
  end

  def load_course
    @course = Course.find_by_id(params[:course_id])
    if @course
      redirect_to new_preorder_path(@course) unless @course.released?
      redirect_to user_course_path(@course) if user_signed_in? && @course.has_student?(current_user)
    else
      redirect_to courses_path, :alert => "Please select a valid course" unless @course
    end
  end
end
