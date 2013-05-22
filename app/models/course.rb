class Course < ActiveRecord::Base
  has_many :enrollments

  attr_accessible :description, :image, :instructor_image, :instructor_name, :instructor_description, :name, :price

  def has_student?(user)
    enrollments.where(user_id: user.id).exists?
  end

  def price_in_cents
    Integer price*100
  end
end
