require 'spec_helper'

describe TodoListsController do
  let(:valid_attributes) { {todo_list: { name: 'todo_list_name'}, :format => 'json'} }
  before(:each) do
    create_ability!
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "POST create" do
    describe "with manage ability" do
      before do
        @ability.can :manage, TodoList
      end
      it "creates a new todo_list" do
        expect {post :create, valid_attributes}.to change(TodoList, :count).by(1)
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, TodoList
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
        @ability.can :manage, TodoList
        @todo_list = FactoryGirl.create(:todo_list)
      end
      it "updates the requested todo_list" do
        put :update, id: @todo_list.id, format: 'json', todo_list: {name: 'new_name'}
        expect(@todo_list.reload.name).to eq("new_name")
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, TodoList
        @todo_list = FactoryGirl.create(:todo_list)
      end
      it "redirects_to root_path" do
        put :update, id: @todo_list.id, format: 'json', todo_list: {name: 'new_name'}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    describe "with manage ability" do
      before do
        @ability.can :manage, TodoList
        @todo_list = FactoryGirl.create(:todo_list)
      end
      it "destroys the requested todo_list" do
        expect {delete :destroy, id: @todo_list.id, format: 'json'}.to change(TodoList, :count).by(-1)
      end
    end
    describe "without mange ability" do
      before do
        @ability.cannot :manage, TodoList
        @todo_list = FactoryGirl.create(:todo_list)
      end
      it "redirects_to root_path" do
        delete :destroy, id: @todo_list.id, format: 'json'
        expect(response).to redirect_to root_path
      end
    end
  end
end
