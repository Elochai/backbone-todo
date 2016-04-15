require 'spec_helper'

describe Task do
   let(:task) { FactoryGirl.create(:task) }
   context "associations" do
    it { expect(task).to belong_to(:todo_list) }
  end

  context "validations" do
    it { expect(task).to validate_presence_of(:desc) }
    it { expect(task).to validate_presence_of(:priority) }
  end
end
