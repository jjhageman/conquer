FactoryGirl.define do
  factory :enrollment do
    user
    course

    factory :purchased_enrollment do
      purchased true
    end
  end
end
