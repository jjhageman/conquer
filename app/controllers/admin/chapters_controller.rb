module Admin
  class ChaptersController < BaseController
    before_filter :load_course

    def show
      @chapter = @course.chapters.find(params[:id]) 
    end

    def new
      @chapter = @course.chapters.build
    end

    def create
      @chapter = @course.chapters.build(params[:chapter])
      if @chapter.save
        redirect_to admin_course_path(@course), notice: 'Chapter successfully created.'
      else
        render 'new'
      end
    end

    def edit
      @chapter = @course.chapters.find(params[:id]) 
    end

    def update
      @chapter = Chapter.find(params[:id])
    
      if @chapter.update_attributes(params[:chapter])
        redirect_to(admin_course_path(@course), notice: 'Chapter was successfully updated.')
      else
        render 'edit'
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
