FactoryGirl.define do
  factory :user do
    full_name 'Yalgın Muzaffer Özseçen'
    sequence(:email) {|n| "user#{n}@example.com"}
    password 'secret99'
    password_confirmation 'secret99'
    confirmed_at Time.now

    factory :admin do
      admin true
    end
  end
end
