module Admin
  class ForumsController < BaseController
    before_filter :load_course

    def index
      @courses = @course.forums.all
    end

    def show
      @course = @course.forums.find_by_url(params[:id])
    end

    def new
      @forum = @course.forums.build
    end

    def create
      @forum = @course.forums.build(params[:forum])
      if @forum.save
        redirect_to admin_course_path(@course), notice: 'Forum successfully created.'
      else
        render 'new'
      end
    end

    private

    def load_course
      unless @course = Course.find_by_url(params[:course_id])
        redirect_to user_root_path, alert: 'Invalid course'
      end
    end
  end
end
