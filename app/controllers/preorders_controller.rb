class PreordersController < ApplicationController
  before_filter :set_return_path, only: :new
  before_filter :load_course, only: :new
  before_filter :authenticate_user!, only: :show

  respond_to :json, only: :create

  def show
    @enrollment = current_user.enrollments.find(params[:id])
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
        sign_in @user 
        create_and_render_enrollment
      else
        render :json => {:errors => errors_for(@user)}, :status => :unprocessable_entity
      end
    end

  end

  private

  def errors_for(object)
    object.errors.map {|k, m| "#{k} #{m}" }
  end

  def create_and_render_enrollment
    @enrollment = @user.enrollments.new(params[:enrollment])
    @enrollment.purchased = false
    if @enrollment.save_and_create_stripe_customer
      render :json => @enrollment
    else
      render :json => {:errors => @enrollment.errors.full_messages}, :status => :unprocessable_entity
    end
  end

  def set_return_path
    unless user_signed_in?
      session[:enrollment_url] = "#{request.fullpath}#order"
    end
  end

  def load_course
    @course = Course.find_by_id(params[:id])
    if @course
      redirect_to new_enrollment_path(@course) if @course.released?
      redirect_to user_course_path(@course) if user_signed_in? && @course.has_student?(current_user)
    else
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end
end
