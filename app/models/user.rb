class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  has_many :enrollments
  has_many :preordered_enrollments, class_name: 'Enrollment', conditions: {purchased: false}
  has_many :purchased_enrollments, class_name: 'Enrollment', conditions: {purchased: true}

  #has_many :courses, through: :enrollments
  has_many :preorders, through: :preordered_enrollments, source: :course
  has_many :courses, through: :purchased_enrollments, source: :course
  has_many :ratings

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me, :last_4_digits, :stripe_id

  def update_stripe_attributes(stripe_customer)
    self.stripe_id = stripe_customer.id if stripe_customer.id
    self.last_4_digits = stripe_customer.active_card.last4 if stripe_customer.active_card.last4
    save!
  end

  def enrolled_in?(course)
    enrollments.purchased.where(course_id: course.id).exists?
  end

  def preordered?(course)
    enrollments.preordered.where(course_id: course.id).exists?
  end
end
