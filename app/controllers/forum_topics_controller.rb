class ForumTopicsController < ApplicationController
  before_filter :authenticate_user!, :load_resources

  def index
    @topics = @forum.topics
  end

  def show
    @topic = @forum.topics.includes(:posts).find_by_url(params[:id])
  end

  def new
    @topic = @forum.topics.build
    @topic.posts.build
  end

  def create
    @topic = current_user.topics.new(params[:forum_topic])
    if @topic.save
      redirect_to forum_topic_path(@course, @forum, @topic), notice: 'Topic successfully created.'
    else
      render :new
    end
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
