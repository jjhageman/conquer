class Course < ActiveRecord::Base
  has_many :enrollments

  attr_accessible :description, :image, :instructor_image, :instructor_name, :instructor_description, :name, :price

  def price_in_cents
    Integer price*100
  end
end
