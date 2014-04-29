require 'spec_helper'
require 'features_spec_helper'

feature "Delete Task", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
  end
  scenario 'An user deletes task successfully' do
    todo_list = user.todo_lists.create!(name: "New name")
    todo_list.tasks.create!(desc: 'new task', priority: 1)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-trash#delete_task').click
    click_on('OK')
    expect(page).to have_content 'Task was successfully deleted!'
    expect(page).to_not have_content 'new task'
  end
end