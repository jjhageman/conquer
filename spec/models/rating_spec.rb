require 'spec_helper'

describe Rating do
  describe '#update_or_create_rating' do
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.create(:course, rating_average: 5) }

    context 'user has not rated course' do
      it 'should create a new rating' do
        expect {
          Rating.update_or_create_rating(course_id: course.id.to_s, stars: '3.5', user_id: user.id.to_s)
        }.to change {user.ratings.count}.from(0).to(1)
      end
    end

    context 'user has already rated course' do
      before :each do
        @rating = FactoryGirl.create(:rating, course: course, user: user, stars: 3.5)
      end

      it 'should update the existing rating' do
        Rating.update_or_create_rating(course_id: course.id.to_s, stars: '4.5', user_id: user.id.to_s).stars.should == 4.5
      end

      it 'should not create a new rating' do
        expect {
          Rating.update_or_create_rating(course_id: course.id.to_s, stars: '4.5', user_id: user.id.to_s)
        }.to change {user.ratings.count}.by(0)
      end

      it 'should not update the record if the star count has not changed' do
        Rating.any_instance.should_not_receive(:update_attribute)
        Rating.update_or_create_rating(course_id: course.id.to_s, stars: @rating.stars.to_s, user_id: user.id.to_s)
      end
    end
  end
end
