class PreordersController < ApplicationController
  before_filter :authenticate_user!, only: :show

  def show
    @enrollment = current_user.enrollments.find(params[:id])
    @course = @enrollment.course
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
    @enrollment = Enrollment.new(params[:enrollment])
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      @enrollment.user = @user
      @enrollment.purchased = false
      if @enrollment.save_and_create_stripe_customer
        redirect_to preorder_path(@enrollment), notice: "Thank you registering!"
      else
        @course = @enrollment.course
        render :new
      end
    else
      @course = @enrollment.course
      render :new
    end
  end
end
