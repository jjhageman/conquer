FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com"}
    password 'secret99'
    password_confirmation 'secret99'
    confirmed_at Time.now
  end
end
