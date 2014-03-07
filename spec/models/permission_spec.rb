require 'spec_helper'

describe Promotion do

  context 'as user' do
    let(:user) { FactoryGirl.create(:user) }
    subject { Permission.new(user) }

    it { should_not permit(:forums, :new) }

  end

  context 'as admin' do
    let(:user) { FactoryGirl.create(:admin) }
    subject { Permission.new(user) }

    it { should permit(:forums, :new) }
  end
end
