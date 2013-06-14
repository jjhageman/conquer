FactoryGirl.define do
  factory :forum do
    sequence(:name) {|n| "Forum #{n}"}
    course
  end
end
