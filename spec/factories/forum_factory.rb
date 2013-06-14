FactoryGirl.define do
  factory :forum do
    sequence(:name) {|n| "Forum #{n}"}
    course
  end

  factory :forum_topic, aliases: [:topic] do
    sequence(:subject) {|n| "Topic #{n}"}
    forum
    user
  end
end
