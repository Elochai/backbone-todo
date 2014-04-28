require 'spec_helper'
require 'features_spec_helper'

feature "Create Task", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    user.todo_lists.create!(name: "New name")
    visit root_path
  end
  scenario 'An user creates new task successfully with valid data' do
    page.find('.input_task').set("new task")
    click_on("Add task")
    expect(page).to have_content 'new task'
    expect(page).to have_content 'Task was successfully created!'
  end
  scenario 'An user can not create new task with invalid data' do
    page.find('.input_task').set("")
    click_on("Add task")
    expect(page).to_not have_content 'new task'
    expect(page).to_not have_content 'Task was successfully created!'
    expect(page).to have_content 'Task description should not be empty!'
  end
end