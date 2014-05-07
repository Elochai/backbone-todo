require 'spec_helper'
require 'features/features_spec_helper'

feature "Drag and drop", :js => true, :driver => :selenium do
  given!(:user) { FactoryGirl.create :user }
  given!(:todo_list) {FactoryGirl.create :todo_list, user_id: user.id}
  given!(:task1) {FactoryGirl.create(:task, priority: 1, todo_list_id: todo_list.id)}
  given!(:task2) {FactoryGirl.create(:task, priority: 2, todo_list_id: todo_list.id)}
  given!(:task3) {FactoryGirl.create(:task, priority: 3, todo_list_id: todo_list.id)}

  before(:each) do
    login_as(user)
    visit root_path
  end
  scenario 'An user drag and drop task successfully' do
    el1 = find("#task#{task1.id}")
    el3 = find("#task#{task3.id}")
    el3.drag_to(el1)
    page.should have_selector('tbody tr:nth-child(1)', text: "#{task3.desc}")
    page.should have_selector('tbody tr:nth-child(2)', text: "#{task1.desc}")
    page.should have_selector('tbody tr:nth-child(3)', text: "#{task2.desc}")
  end
end