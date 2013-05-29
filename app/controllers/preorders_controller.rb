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
    @enrollment = Enrollment.new(params[:enrollment])
    @course = @enrollment.course

    @user = if user_signed_in?
      current_user
    else
      new_user = User.new(params[:user])
      sign_in new_user if new_user.save
      new_user
    end

    if @user.persisted? && @user.valid?
      @enrollment.user = @user
      @enrollment.purchased = false
      flash[:notice] = "Thank you registering!" if @enrollment.save_and_create_stripe_customer
      respond_with(@enrollment) { |format| format.html {redirect_to preorder_path(@enrollment)}}
    else
      respond_with(@user) {|format| format.html {render :new}}
    end
  end

  private

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
