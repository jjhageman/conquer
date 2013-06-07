class RatingsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def create
    @rating = CourseRating.new(rating: params[:rating], user: current_user).update_or_create_rating
    respond_with @rating
  end
end
