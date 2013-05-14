class Course < ActiveRecord::Base
  attr_accessible :description, :image, :instructor_image, :instructor_name, :instructor_description, :name, :price
  has_many :enrollments
end
