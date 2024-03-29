# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

course1 = Course.create(
  name: 'Business Networking Tips',
  tagline: 'Network Yourself Into Your Dream Job',
  description: <<eos,
Most people go to an industry convention, work holiday party or even lunch and just talk to the people they already know. This is a big mistake.

Harvard Professor Samantha Powers, pioneer of power business networking, has studied professional social interactions for decades. She's published cutting edge research on what types of business networking lead to the best job and career outcomes and how to create intimacy quickly. She'll share her business networking tips.

In this class she'll not only make you a better business networker, but help you figure out how to do it in a way that is authentic to you.
eos
  price: 9.99,
  total_hours: 8,
  image: '',
  hero_image: '',
  playlist_id: '2361189644001',
  instructor_name: 'Keith Ferrazzi',
  instructor_title: 'New York Times Best Seller',
  instructor_description: <<eos,
Keith Ferrazzi is an American author and the founder and CEO of Ferrazzi Greenlight, a research institute and strategic consulting firm focused on relational, collaborational and behavioral sciences based in Los Angeles.
eos
  instructor_image: 'ferrazzi.jpg',
  released: true,
  start_date: Time.now
)

Chapter.create(
  name: 'Chapter 1',
  description: 'Material for chapter 1',
  course_id: course1.id
)

Chapter.create(
  name: 'Chapter 2',
  description: 'Material for chapter 2',
  course_id: course1.id
)

Chapter.create(
  name: 'Chapter 3',
  description: 'Material for chapter 3',
  course_id: course1.id
)

Chapter.create(
  name: 'Chapter 4',
  description: 'Material for chapter 4',
  course_id: course1.id
)

Promotion.create(
  code: 'ofjrfk',
  price: 5.99,
  video_id: '2361189644001',
  content: <<eos,
<h4>About the Class</h4>
Most people go to an industry convention, work holiday party or even lunch and just talk to the people they already know. This is a big mistake.

Harvard Professor Samantha Powers, pioneer of power business networking, has studied professional social interactions for decades. She&#x27;s published cutting edge research on what types of business networking lead to the best job and career outcomes and how to create intimacy quickly. She&#x27;ll share her business networking tips.

In this class she&#x27;ll not only make you a better business networker, but help you figure out how to do it in a way that is authentic to you.

<h4>About Keith Ferrazzi</h4>
<p>Keith Ferrazzi is an American author and the founder and CEO of Ferrazzi Greenlight, a research institute and strategic consulting firm focused on relational, collaborational and behavioral sciences based in Los Angeles.</p>
eos
  active: true,
  course_id: course1.id)

course2 = Course.create(
  name: 'How To Be Funny',
  tagline: 'Win Friends and Influence People',
  description: <<eos,
The ability to create humor is a skill many people don't have, yet wish they did. If you're interested in learning how to come up with jokes or witticisms on the fly, punch up dull material for an audience, or make a living as a comedy writer, this course will get you going.

Your instructor, an experienced comedy writer and working actress, will guide you through a wide range of comedic sources. You'll learn how to write a one-liner, use physical humor, target your audience, find the humor in everyday events and much, much more. 

Once you've learned some of the methods of creating humor, you'll be ready to apply it to all aspects of your life. Punch up speeches and presentations so that the audience is instantly on your side. Mix laughter with learning in the classroom, and watch your students' attention spans grow. Add some humor to your web page and watch the hits explode as word gets out. Use your newfound sense of humor to entertain your friends, meet interesting people, and even make new friends! 
eos
  price: 9.99,
  total_hours: 8,
  image: '',
  hero_image: '',
  playlist_id: '2361189644001',
  instructor_name: 'Drew Carey',
  instructor_title: 'New York Times Best Seller',
  instructor_description: <<eos,
Carey has appeared in several films, television series, music videos, a made-for-television film, and a computer game. He has hosted the television game show The Price Is Right since 2007. He is interested in a variety of sports, has worked as a photographer at U.S. National Team soccer games, is a minority owner of the Major League Soccer team Seattle Sounders FC and a member of the WWE Hall of Fame. Carey has written an autobiography, Dirty Jokes And Beer: Stories Of The Unrefined, detailing his early life and television career.
eos
  instructor_image: 'carey.jpg',
  released: false,
  start_date: Time.now + 2.months)

Chapter.create(
  name: 'Chapter 1',
  description: 'Material for chapter 1',
  course_id: course2.id
)

Chapter.create(
  name: 'Chapter 2',
  description: 'Material for chapter 2',
  course_id: course2.id
)

Chapter.create(
  name: 'Chapter 3',
  description: 'Material for chapter 3',
  course_id: course2.id
)

Chapter.create(
  name: 'Chapter 4',
  description: 'Material for chapter 4',
  course_id: course2.id
)

Promotion.create(
  code: 'zvdoiq',
  price: 8.99,
  video_id: '2361189644001',
  content: <<eos,
<h4>About the Class</h4>
      The ability to create humor is a skill many people don&#x27;t have, yet wish they did. If you&#x27;re interested in learning how to come up with jokes or witticisms on the fly, punch up dull material for an audience, or make a living as a comedy writer, this course will get you going.

Your instructor, an experienced comedy writer and working actress, will guide you through a wide range of comedic sources. You&#x27;ll learn how to write a one-liner, use physical humor, target your audience, find the humor in everyday events and much, much more. 

Once you&#x27;ve learned some of the methods of creating humor, you&#x27;ll be ready to apply it to all aspects of your life. Punch up speeches and presentations so that the audience is instantly on your side. Mix laughter with learning in the classroom, and watch your students&#x27; attention spans grow. Add some humor to your web page and watch the hits explode as word gets out. Use your newfound sense of humor to entertain your friends, meet interesting people, and even make new friends! 

      <h4>About Drew Carey</h4>
      <p>Carey has appeared in several films, television series, music videos, a made-for-television film, and a computer game. He has hosted the television game show The Price Is Right since 2007. He is interested in a variety of sports, has worked as a photographer at U.S. National Team soccer games, is a minority owner of the Major League Soccer team Seattle Sounders FC and a member of the WWE Hall of Fame. Carey has written an autobiography, Dirty Jokes And Beer: Stories Of The Unrefined, detailing his early life and television career.</p>
eos
  active: true,
  course_id: course2.id)

forum1 = Forum.create(
  name: 'Assignments',
  description: 'Specific questions and clarifications about the assignments.',
  course: course1
)

forum2 = Forum.create(
  name: 'General Discussion',
  description: 'General discussion about the course, life, and everything under the sun.',
  course: course1
)

user1 = User.create(
  full_name: 'Yalgın Muzaffer Özseçen',
  email: 'new@user.com',
  password: 'secret99',
  password_confirmation: 'secret99',
)
user1.confirm!

admin = User.create(
  full_name: 'Admin User',
  email: 'admin@user.com',
  password: 'secret99',
  password_confirmation: 'secret99'
)
admin.update_attribute(:admin, true)
admin.confirm!

e = Enrollment.create(
  user_id: user1.id,
  course_id: course1.id
)
e.update_attribute :purchased, true

topic1 = ForumTopic.new(
  subject: 'Is this course coming back soon?',
  last_post_at: 2.months.ago,
  views_count: 23,
  forum: forum2,
  user: user1
)

topic1.posts << ForumPost.new(
  text:<<eos,
A friend told me about this course on Monday evening (he's taking it at the moment). I signed up but realise its way too late to work through the materials and assignments at this stage.

I would love to take this course when it comes round again, and have some questions:

When will this course run again?
Do I have to be enrolled to access the course materials? 
Will I be penalised for remaining enrolled on a course which I didn't submit anything towards (particularly in terms of taking it when it starts).

I did see elsewhere in the forum that the materials do remain available after the course ends.
eos
  user: user1,
  topic: topic1
)

topic1.save
