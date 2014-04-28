require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  context "associations" do
    it { expect(user).to have_many(:todo_lists).dependent(:destroy) }
  end
   context "validations" do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to allow_value("example@gmail.com").for(:email) }
    it { expect(user).not_to allow_value("example.com").for(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }
  end
end