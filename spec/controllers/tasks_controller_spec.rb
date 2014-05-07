require 'spec_helper'
require 'ability_spec_helper'

describe TasksController do
  let(:valid_attributes) { {task: { desc: 'task_desc', priority: 1 }, :format => 'json'} }
  before(:each) do
    create_ability!
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "POST create" do
    describe "with manage ability" do
      before do
        @ability.can :manage, Task
      end
      it "creates a new Task" do
        expect {post :create, valid_attributes}.to change(Task, :count).by(1)
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, Task
      end
      it "redirects_to root_path" do
        post :create, valid_attributes
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PUT update" do
    describe "with manage ability" do
      before do
        @ability.can :manage, Task
        @task = FactoryGirl.create(:task)
      end
      it "updates the requested task" do
        put :update, id: @task.id, format: 'json', task: {desc: 'new_desc'}
        expect(@task.reload.desc).to eq("new_desc")
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, Task
        @task = FactoryGirl.create(:task)
      end
      it "redirects_to root_path" do
        put :update, id: @task.id, format: 'json', task: {desc: 'new_desc'}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    describe "with manage ability" do
      before do
        @ability.can :manage, Task
        @task = FactoryGirl.create(:task)
      end
      it "destroys the requested task" do
        expect {delete :destroy, id: @task.id, format: 'json'}.to change(Task, :count).by(-1)
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, Task
        @task = FactoryGirl.create(:task)
      end
      it "redirects_to root_path" do
        delete :destroy, id: @task.id, format: 'json'
        expect(response).to redirect_to root_path
      end
    end
  end
end
