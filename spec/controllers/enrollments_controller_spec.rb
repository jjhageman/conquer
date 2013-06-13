require 'spec_helper'
include StripeMacro

describe EnrollmentsController do
  let(:course) { FactoryGirl.create(:course) }

  describe 'POST create', :vcr do

    context 'New user' do
      #"user"=>{"full_name"=>"Jeremy Hageman", "email"=>"jjhageman@gmail.com"}, 
      #"enrollment"=>{"course_id"=>"2", "stripe_token"=>"", "promotion_id"=>"", "course_price"=>""},
      #"course_id"=>"drew-carey-how-to-be-funny"
      let(:params) {{
        'user' => {'full_name' => 'Marie-Élise L’Antisémite', 'email' => 'new@user.com'},
        'enrollment' => {'course_id' => course.id},
        'course_id' => course.url
      }}

      before :each do
        stub_stripe_customer
      end

      it 'should create a new user account' do
        expect {
          post :create, params
        }.to change{User.count}.from(0).to(1)
      end
    end

  end
end
