class RatingsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def create
    @rating = Rating.new(params[:rating])
    @rating.user = current_user
    flash[:notice] = 'User was successfully created.' if @rating.save
    respond_with @rating
  end
end
