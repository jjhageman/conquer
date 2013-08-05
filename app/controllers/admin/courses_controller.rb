module Admin
  class CoursesController < BaseController
    def index
      @courses = Course.all
    end

    def show
      @course = Course.find_by_url(params[:id])
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(params[:course])
      if @course.save
        redirect_to admin_course_path(@course), notice: 'Course successfully created.'
      else
        render 'new'
      end
    end

    def edit
      @course = Course.find_by_url(params[:id])
    end

    def update
      @course = Course.find_by_url(params[:id])
    
      if @course.update_attributes(params[:course])
        redirect_to admin_course_path(@course), notice: 'Chapter was successfully updated.'
      else
        render 'edit'
      end
    end
  end
end
