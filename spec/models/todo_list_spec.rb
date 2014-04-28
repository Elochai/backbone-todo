require 'spec_helper'

describe TodoList do
  let(:todo_list) { FactoryGirl.create(:todo_list) }
  context "associations" do
    it { expect(todo_list).to have_many(:tasks).dependent(:destroy) }
    it { expect(todo_list).to belong_to(:user) }
  end

  context "validations" do
    it { expect(todo_list).to validate_presence_of(:name) }
  end
end