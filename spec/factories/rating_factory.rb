FactoryGirl.define do
  factory :rating do
    user
    course
    stars 3.5
  end
end
