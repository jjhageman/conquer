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
  description: <<eos,
Most people go to an industry convention, work holiday party or even lunch and just talk to the people they already know. This is a big mistake.

Harvard Professor Samantha Powers, pioneer of power business networking, has studied professional social interactions for decades. She's published cutting edge research on what types of business networking lead to the best job and career outcomes and how to create intimacy quickly. She'll share her business networking tips.

In this class she'll not only make you a better business networker, but help you figure out how to do it in a way that is authentic to you.
eos
  price: 9.99,
  image: '',
  instructor_name: 'Keith Ferrazzi',
  instructor_description: <<eos,
Keith Ferrazzi is an American author and the founder and CEO of Ferrazzi Greenlight, a research institute and strategic consulting firm focused on relational, collaborational and behavioral sciences based in Los Angeles.
eos
  instructor_image: 'ferrazzi.jpg',
  released: true,
  start_date: Time.now
)

Promotion.create(
  code: 'XQSE',
  price: 5.99,
  active: true,
  course_id: course1.id)

Course.create(
  name: 'How To Be Funny',
  description: <<eos,
The ability to create humor is a skill many people don't have, yet wish they did. If you're interested in learning how to come up with jokes or witticisms on the fly, punch up dull material for an audience, or make a living as a comedy writer, this course will get you going.

Your instructor, an experienced comedy writer and working actress, will guide you through a wide range of comedic sources. You'll learn how to write a one-liner, use physical humor, target your audience, find the humor in everyday events and much, much more. 

Once you've learned some of the methods of creating humor, you'll be ready to apply it to all aspects of your life. Punch up speeches and presentations so that the audience is instantly on your side. Mix laughter with learning in the classroom, and watch your students' attention spans grow. Add some humor to your web page and watch the hits explode as word gets out. Use your newfound sense of humor to entertain your friends, meet interesting people, and even make new friends! 
eos
  price: 9.99,
  image: '',
  instructor_name: 'Drew Carey',
  instructor_description: <<eos,
Carey has appeared in several films, television series, music videos, a made-for-television film, and a computer game. He has hosted the television game show The Price Is Right since 2007. He is interested in a variety of sports, has worked as a photographer at U.S. National Team soccer games, is a minority owner of the Major League Soccer team Seattle Sounders FC and a member of the WWE Hall of Fame. Carey has written an autobiography, Dirty Jokes And Beer: Stories Of The Unrefined, detailing his early life and television career.
eos
  instructor_image: 'carey.jpg',
  start_date: Time.now + 2.months)
