module Admin
  class PromotionsController < BaseController
    before_filter :load_course

    def show
      @promotion = @course.promotions.find_by_code(params[:id])
    end

    private

    def load_course
      unless @course = Course.find_by_url(params[:course_id])
        redirect_to user_root_path, alert: 'Invalid course'
      end
    end
  end
end
