require 'spec_helper'
require 'features/features_spec_helper'

feature "Delete Task", :js => true do
  given!(:user) { FactoryGirl.create :user }
  given!(:todo_list) { FactoryGirl.create :todo_list, user_id: user.id }
  given!(:task) { FactoryGirl.create :task, todo_list_id: todo_list.id }
  before(:each) do
    login_as(user)
  end
  scenario 'An user deletes task successfully' do
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-trash#delete_task').click
    click_on('OK')
    expect(page).to have_content 'Task was successfully deleted!'
    expect(page).to_not have_content "#{task.desc}"
  end
end