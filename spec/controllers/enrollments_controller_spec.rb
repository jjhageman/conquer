require 'spec_helper'
include StripeMacro

describe EnrollmentsController do
  let(:course) { FactoryGirl.create(:course) }

  describe 'POST create', :vcr do

    context 'invalid email' do
      let(:params) {{
        'user' => {'full_name' => 'Marie-Élise L’Antisémite', 'email' => 'invalid'},
        'enrollment' => {'course_id' => course.id, 'stripe_token' => 'tok_20ViXjlKQQQ21j'},
        'course_id' => course.url
      }}

      it 'should not create a user or enrollment' do
        User.should_not_receive(:new)

        expect {
          post :create, params
        }.to change{Enrollment.count}.by(0)
      end
    end

    context 'New user' do
      let(:params) {{
        'user' => {'full_name' => 'Marie-Élise L’Antisémite', 'email' => 'new@user.com'},
        'enrollment' => {'course_id' => course.id, 'stripe_token' => 'tok_20ViXjlKQQQ21j'},
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

    context 'Existing user' do
      let(:user) { FactoryGirl.create(:user) }

      let(:params){{
        "enrollment"=>{"course_id"=>course.id, "stripe_token"=>"tok_20ViXjlKQQQ21j", "promotion_id"=>"", "course_price"=>""},
        'course_id' => course.url
      }}

      before :each do
        sign_in user
        stub_stripe_customer
      end

      it 'should not create a new user account' do
        User.should_not_receive(:new)
        post :create, params
      end

      it 'should create an enrollment' do
        expect{
          post :create, params
        }.to change{user.enrollments.count}.from(0).to(1)
      end

      it 'should send a confirmation email' do
        emailer = double 'email'
        emailer.should_receive(:deliver)
        
        UserMailer.should_receive(:purchase_email).with(user, course, course.price).and_return(emailer)
        post :create, params
      end

      it 'should redirect if the user is already enrolled'
      it 'should redirect if the user has already pre-ordered'
    end


    it 'should redirect for invalid course ids' do
      post :create, 'course_id' => 'invalid'
      response.should redirect_to(courses_path)
    end

  end
end
