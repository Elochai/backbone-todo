require 'spec_helper'

feature "Set task deadline", :js => true do
  given!(:user) { FactoryGirl.create :user }
  given!(:todo_list) { FactoryGirl.create :todo_list, user_id: user.id }
  given!(:task) { FactoryGirl.create :task, todo_list_id: todo_list.id }
  before(:each) do
    login_as(user)
  end
  scenario 'An user sets deadline successfully for incompleted task' do
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-pencil#edit_task').click
    page.find('#input_deadline').click
    page.find('#update_task').trigger('click')
    expect(page).to have_content 'Task was successfully updated!'
  end
  scenario 'An user can not set deadline for already completed task' do
    task.update(completed:true)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-pencil#edit_task').click
    expect(page).to have_content "Can't update already completed task!"
  end
end