class Promotion < ActiveRecord::Base
  belongs_to :course

  scope :active, where(active: true)

  attr_accessible :active, :code, :price, :course_id, :video_id, :content

  before_validation(:on => :create) { create_code }

  validates :code, presence: true, uniqueness: true
  validates :price, presence: true
  validates_associated :course

  def to_param
    code
  end

  def create_code
    self.code = generate_code unless attribute_present?("code")
  end

  def generate_code(length=6)
    (0...length).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  def price_in_cents
    Integer price*100
  end
end
