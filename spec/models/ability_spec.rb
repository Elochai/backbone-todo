require "spec_helper"
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    let(:user) {}
    subject(:ability){ Ability.new(user) }

    context "when signed in" do
      let(:user){ FactoryGirl.create :user}
      it{ should be_able_to(:manage, TodoList.new(:user_id => user.id)) }
      it{ should_not be_able_to(:manage, TodoList.new(:user_id => user.id + 1)) }
      it{ should be_able_to(:manage, Task.new(:todo_list => FactoryGirl.build(:todo_list, :user_id => user.id))) }
      it{ should_not be_able_to(:manage, Task.new(:todo_list => FactoryGirl.build(:todo_list, :user_id => user.id + 1))) }
    end

    context "when not signed in" do
      it{ should_not be_able_to(:manage, :all) }
    end        
  end
end