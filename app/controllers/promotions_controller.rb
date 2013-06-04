class PromotionsController < ApplicationController
  def show
    code = params[:code].downcase
    if @promo = Promotion.active.find_by_code(code)
      @course = @promo.course
      @enrollment = @course.enrollments.new
      @enrollment.promotion = @promo
      @enrollment.course_price = @promo.price
    else
      redirect_to courses_path, alert: "The promo code '#{code}' is not valid"
    end
  end
end
