class ForumTopicsController < ApplicationController
  before_filter :load_resources

  def index
    @topics = @forum.topics
  end

  private

  def load_resources
    unless @course = Course.find_by_url(params[:course_id])
      redirect_to user_root_path, alert: 'Invalid course'
    end

    unless @forum = @course.forums.find_by_url(params[:forum_id])
      redirect_to forums_path(@course), alert: 'Invalid forum'
    end
  end
end