class EnrollmentsController < ApplicationController
  before_filter :set_return_path, only: :new
  before_filter :load_course, only: [:new, :create]

  def show
    @enrollment = Enrollment.find(params[:id])
    @course = @enrollment.course
  end

  def new
    @enrollment = @course.enrollments.new
  end
  
  def create
    @user = if user_signed_in?
      current_user
    else
      User.new(params[:user])
    end

    if user_signed_in?
      create_and_render_enrollment
    else
      if @user.save
        #sign_in @user
        create_and_render_enrollment
      else
        @enrollment = Enrollment.new(params[:enrollment])
        render :new
      end
    end
  end

  private

  def create_and_render_enrollment
    @enrollment = @user.enrollments.new(params[:enrollment])
    if @enrollment.save_and_do_financials
      redirect_to @enrollment, notice: "Thank you for enrolling!"
    else
      render :new
    end
  end

  def set_return_path
    unless user_signed_in?
      session[:enrollment_url] = request.fullpath
    end
  end

  def load_course
    @course = Course.find_by_url(params[:course_id])
    if @course
      redirect_to user_course_path(@course) if user_signed_in? && @course.has_student?(current_user)
      redirect_to course_path(@course) if user_signed_in? && @course.has_preordered_student?(current_user)
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end
end
