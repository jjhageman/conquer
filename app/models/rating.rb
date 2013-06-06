class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  attr_accessible :stars, :course_id, :user_id
end
