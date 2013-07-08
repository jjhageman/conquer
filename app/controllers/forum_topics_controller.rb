class ForumTopicsController < ApplicationController
  before_filter :authenticate_user!, :load_resources

  def index
    @topics = @forum.topics.visible.by_pinned_or_most_recent_post
  end

  def show
    if @topic = @forum.topics.includes(:posts).find_by_url(params[:id])
      register_view @topic, current_user
    else
      redirect_to forum_topics_path(@course, @forum), alert: 'Invalid topic'
    end
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

  def register_view(topic, user)
    topic.register_view_by user
  end

  def load_resources
    unless @course = Course.find_by_url(params[:course_id])
      redirect_to user_root_path, alert: 'Invalid course'
    end

    unless @forum = @course.forums.find_by_url(params[:forum_id])
      redirect_to forums_path(@course), alert: 'Invalid forum'
    end
  end
end
