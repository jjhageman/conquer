class PromotionsController < ApplicationController
  def show
    code = params[:code].downcase
    if @promo = Promotion.active.find_by_code(code)
      @course = @promo.course
      @enrollment = @course.enrollments.new
    else
      redirect_to courses_path, alert: "The promo code '#{code}' is not valid"
    end
  end
end
