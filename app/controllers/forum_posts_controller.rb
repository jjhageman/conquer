class ForumPostsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  def create
    @post = current_user.posts.create!(params[:forum_post])
    respond_with @post
  end
end
