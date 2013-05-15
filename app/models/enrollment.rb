class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  attr_accessible :stripe_token
  attr_accessor :stripe_token
end
