FactoryGirl.define do
  factory :enrollment do
    user
    course
<<<<<<< Updated upstream

    factory :purchased_enrollment do
=======
    
    factory :purchased_course do
>>>>>>> Stashed changes
      purchased true
    end
  end
end
