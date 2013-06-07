require 'spec_helper'

describe CourseRating do
  let(:course) { FactoryGirl.create(:course) }
  let(:user) { FactoryGirl.create(:user) }
  let(:cr) { CourseRating.new(course: course, user: user) }

  describe '.stars_by_user_or_average' do
    context 'user has not rated course' do
      it 'should return the course average rating' do

      end
    end

    context 'user has already rated course' do
      before :each do
        @rating = FactoryGirl.create(:rating, course: course, user: user)
      end

      it 'should return the users star count' do
        cr.stars_by_user_or_average.should == @rating.stars
      end
    end
  end
end
