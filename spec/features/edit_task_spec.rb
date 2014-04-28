require 'spec_helper'
require 'features_spec_helper'

feature "Edit Task", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    todo_list = user.todo_lists.create!(name: "New name")
    todo_list.tasks.create!(desc: "new task", priority: 1)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-pencil#edit_task').click
  end
  scenario 'An user edits task successfully with valid data' do
    within '.edit_task_form' do
      page.find('.task_edit_input').set("Updated task")
    end
    page.find('.icon-ok').click
    expect(page).to have_content 'Task was successfully updated!'
    expect(page).to have_content 'Updated task'
    expect(page).to_not have_content 'New task'
  end
  scenario 'An user can not edit task with invalid data' do
    within '.edit_task_form' do
      page.find('.task_edit_input').set("")
    end
    page.find('#update_task').click
    expect(page).to have_content 'Task description should not be empty!'
    expect(page).to_not have_content 'Updated task'
  end
end