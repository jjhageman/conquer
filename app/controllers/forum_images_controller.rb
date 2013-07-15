class ForumImagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @image = ForumImage.new
  end

  def show
    @image = ForumImage.find(params[:id])
  end

  def create
    @gallery = ForumGallery.new
    @image = @gallery.images.new(params[:forum_image])
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image }
        format.js
      else
        format.html { render 'new' }
        format.js
      end
    end
  end
end
