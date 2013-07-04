module Admin
  class PromotionsController < BaseController
    before_filter :load_course

    def show
      @promotion = @course.promotions.find_by_code(params[:id]) 
    end

    def new
      @promotion = @course.promotions.build
      @promotion.create_code
    end

    def create
      @promotion = @course.promotions.build(params[:promotion])
      if @promotion.save
        redirect_to admin_course_path(@course), notice: 'Promotion successfully created'
      else
        render 'new'
      end
    end

    def edit
      @promotion = @course.promotions.find_by_code(params[:id]) 
    end

    def update
      @promotion = Promotion.find_by_code(params[:id])
      if @promotion.update_attributes(params[:promotion])
        redirect_to admin_course_path(@course), notice: 'Promotion successfully updated'
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
