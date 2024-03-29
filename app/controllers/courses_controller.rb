class CoursesController < ApplicationController

  def index
    @courses = Course.active
    @preorders = Course.preorder
  end

  def show
    unless @course = Course.includes(:chapters).find_by_url(params[:id])
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end
end
