# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Course.create(
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
  instructor_image: 'ferrazzi.jpg')
