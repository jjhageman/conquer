class ForumsController < ApplicationController
  before_filter :load_course

  def index
    @forums = @course.forums
  end

  private

  def load_course
    unless @course = Course.find_by_url(params[:course_id])
      redirect_to user_root_path, alert: 'Invalid course'
    end
  end
end
