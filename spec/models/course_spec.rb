require 'spec_helper'

describe Course do
  let(:course) { FactoryGirl.create(:course) }
  let(:user) { FactoryGirl.create(:user) }

  describe '.rated_by?(user)' do
    it 'should return false if user has not rated course' do
      course.rated_by?(user).should be_false
    end

    it 'should return true if user has rated course' do
      FactoryGirl.create(:rating, user: user, course: course)
      course.rated_by?(user).should be_true
    end
  end
end
