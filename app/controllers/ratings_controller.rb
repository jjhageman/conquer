class RatingsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def create
    respond_with Rating.update_or_create_rating(params[:rating].merge(user_id: current_user.id))
  end
end
