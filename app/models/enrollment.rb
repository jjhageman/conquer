class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  attr_accessible :user_id, :course_id, :stripe_token, :price_paid, :purchase_date
  attr_accessor :stripe_token

  validates :course_id, :uniqueness => { :scope => :user_id,
    :message => "you have already enrolled in this course" }

  scope :purchased, where(purchased: true)
  scope :preordered, where(purchased: false)

  def save_and_make_payment
    if valid?
      customer = create_stripe_customer
      charge_customer(customer)
      user.update_stripe_attributes(customer)
      save!
    end

  rescue Stripe::CardError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def save_and_create_stripe_customer
    if valid?
      customer = create_stripe_customer
      user.update_stripe_attributes(customer)
      save!
    end
  end

  def create_stripe_customer
    Stripe::Customer.create(:card => stripe_token, :description => user.email)
  end

  def charge_customer(customer)
    Stripe::Charge.create(
      amount: course.price_in_cents,
      currency: "usd",
      customer: customer.id,
      description: "#{course.id}: #{course.name}")
  end
end
