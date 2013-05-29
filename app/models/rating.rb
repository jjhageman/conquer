class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  attr_accessible :float
end
