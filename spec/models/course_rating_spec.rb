require 'spec_helper'

describe CourseRating do
  let(:course) { FactoryGirl.create(:course, rating_average: 5) }
  let(:user) { FactoryGirl.create(:user) }

  describe '.stars_by_user_or_average' do
    let(:cr) { CourseRating.new(course: course, user: user) }

    context 'user has not rated course' do
      it 'should return the course average rating' do
        cr.stars_by_user_or_average.should == course.rating_average
      end
    end

    context 'user has already rated course' do
      before :each do
        @rating = FactoryGirl.create(:rating, course: course, user: user, stars: 3.5)
      end

      it 'should return the users star count' do
        cr.stars_by_user_or_average.should == @rating.stars
      end
    end
  end
end
