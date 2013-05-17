class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  attr_accessible :user_id, :course_id, :stripe_token
  attr_accessor :stripe_token

  validates :course_id, :uniqueness => { :scope => :user_id,
    :message => "you have already enrolled in this course" }

  def save_and_make_payment
    if valid?
      customer = Stripe::Customer.create(:card => stripe_token, :description => user.email)

      # Charge the Customer instead of the card
      Stripe::Charge.create(
        amount: course.price_in_cents,
        currency: "usd",
        customer: customer.id,
        description: "#{course.id}: #{course.name}"
      )

      # Save the customer ID in your database so you can use it later
      user.update_stripe_attributes(customer)
      save!
    end
  end
end
