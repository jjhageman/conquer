class ForumPostsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  def create
    #@post = current_user.posts.create!(params[:forum_post])
    @post = current_user.posts.build(params[:forum_post])
    @post.image_ids = params[:image_ids].split(',') unless params[:image_ids].blank?
    @post.save
    respond_with @post
  end

end
