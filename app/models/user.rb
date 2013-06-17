class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  has_many :enrollments, dependent: :destroy
  has_many :preordered_enrollments, class_name: 'Enrollment', conditions: {purchased: false}
  has_many :purchased_enrollments, class_name: 'Enrollment', conditions: {purchased: true}

  has_many :preorders, through: :preordered_enrollments, source: :course
  has_many :courses, through: :purchased_enrollments, source: :course
  has_many :ratings, dependent: :destroy
  has_many :posts, class_name: 'ForumPost'

  validates :full_name, presence: true

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me, :last_4_digits, :stripe_id

  def enrolled_in?(course)
    enrollments.purchased.where(course_id: course.id).exists?
  end

  def preordered?(course)
    enrollments.preordered.where(course_id: course.id).exists?
  end

  def update_stripe_attributes(stripe_customer)
    self.stripe_id = stripe_customer.id if stripe_customer.id
    self.last_4_digits = stripe_customer.active_card.last4 if stripe_customer.active_card.last4
    save!
  end

  ### Devise monkeypatches ###

  def send_confirmation_notification?
    false
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
end
