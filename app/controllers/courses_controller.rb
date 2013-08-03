class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def show
    unless @course = Course.find_by_url(params[:id])
      redirect_to courses_path, :alert => "Please select a valid course"
    end
  end
end
