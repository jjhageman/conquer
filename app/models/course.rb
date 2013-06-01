class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :promotions
  has_many :ratings

  scope :active, where(released: true)

  attr_accessible :description, :image, :instructor_image, :instructor_name, :instructor_description, :name, :price, :released, :start_date

  validates :name, presence: true
  validates :price, presence: true
  validates :start_date, presence: true

  def has_student?(user)
    enrollments.purchased.where(user_id: user.id).exists?
  end

  def has_preordered_student?(user)
    enrollments.preordered.where(user_id: user.id).exists?
  end

  def price_in_cents
    Integer price*100
  end
end
