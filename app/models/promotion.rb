class Promotion < ActiveRecord::Base
  attr_accessible :active, :code, :price, :course_id
end
