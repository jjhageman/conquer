class RatingsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def create
    @course = Course.find(params[:course_id])
    @rating = Rating.new(params[:rating])
    respond_with @course
  end
end
