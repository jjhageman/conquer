class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :promotion

  attr_accessible :user_id, :course_id, :promotion_id, :stripe_token, :course_price, :purchase_date
  attr_accessor :stripe_token

  validates :course_id, uniqueness: { scope: :user_id,
                                      message: 'you have already enrolled in this course' }

  scope :purchased, where(purchased: true)
  scope :preordered, where(purchased: false)

  def save_and_do_financials
    if valid?
      customer = create_stripe_customer
      if course.released?
        charge_customer(customer)
        self.purchased = true
        self.purchase_date = Time.now
      else
        self.purchased = false
      end
      user.update_stripe_attributes(customer)
      save!
    end

  rescue Stripe::CardError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, 'There was a problem with your credit card.'
    false
  end

  def course_price
    @course_price ||= promotion ? promotion.price : course.price
  end

  def course_price_in_cents
    Integer course_price * 100
  end

  def send_confirmation_email
    user.confirmed? ? UserMailer.purchase_email(user, course, course_price).deliver : UserMailer.confirmation_and_purchase_email(user, course, course_price).deliver
  end

  private

  def create_stripe_customer
    Stripe::Customer.create(card: stripe_token, description: user.email)
  end

  def charge_customer(customer)
    Stripe::Charge.create(
      amount: course_price_in_cents,
      currency: 'usd',
      customer: customer.id,
      description: "#{course.id}: #{course.name}")
  end
end
