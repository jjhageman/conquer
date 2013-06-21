class ForumsController < ApplicationController
  before_filter :authenticate_user!, :load_course

  def index
    @forums = @course.forums
  end

  def new
    @forum = @course.forums.build
  end

  private

  def load_course
    unless @course = Course.find_by_url(params[:course_id])
      redirect_to user_root_path, alert: 'Invalid course'
    end
  end
end
