FactoryGirl.define do
  factory :course do
    sequence(:name)  { |n| "Course #{n}: How To Be Awesome" }
    price 9.99
    description "Class of 2014 is really the last best class. Well, today was my last ballet class. :( ballet exam on Thursday and I'm officially done with it. 11 years? Was a good run. Retirement time.. can't spend 3 hours in mr. lee's class.. just can't do it. Go Pens. Iginla is pure class and deserves a cup. Not convinced they can win it all with Vokoun though...... Screw my 2nd period class you guys snitch a lot. Us High Class Niggaz. Thank u tafuro! 92 in my speech clinical class :). I'm only close to a handful of people in my class.... NSAA Girls Soccer Class B Championship - Elkhorn South 2, Omaha Skutt Catholic 2, :34 left 2nd Half. good tweetsters don't need to talk about things like jeans or boners. We have class, and can discuss the latest operas and plays etc.. THERES A GIRL IN MY ENGLISH CLASS GOING TO SEE TSWIZZLE AND ED ON THURSDAY AND SHE SAID SHE'S GOING FOR ED BUT SHE DOESNT KNOW HIS SONGS?¿??. Wanting extra incentive to sign up for a class online? A class registered online will also get you an admission ticket!."
    instructor_name 'Rich Mullane'
    instructor_description "MTA Attorney Rich Mullane is a skilled advocate, a great instructor and a firm believer in member empowerment.. Just got a text msg from my clinical instructor Saying for such a young person you're amazing"
    start_date Date.today

    factory :prereleased_course do
      released false
      start_date 1.month.from_now
    end
  end
end
