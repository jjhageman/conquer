class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  after_save :update_course_average_rating

  attr_accessible :stars, :course_id, :user_id

  validates :user_id, uniqueness: { scope: :course_id,
    message: "you have already rated this course" }

  def update_course_average_rating
    course.update_cached_average
  end
end
