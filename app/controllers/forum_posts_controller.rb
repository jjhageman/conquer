class ForumPostsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def create
    respond_with current_user.posts.create(params[:forum_post])
  end
end
