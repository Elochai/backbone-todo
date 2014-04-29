require 'spec_helper'
require 'features_spec_helper'

feature "Set task deadline", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    @todo_list = user.todo_lists.create!(name: "New name")
  end
  scenario 'An user sets deadline successfully for incompleted task' do
    @todo_list.tasks.create!(desc: "new task", priority: 1, completed: false)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-exclamation-sign#choose_deadline').click
    page.find('#set_deadline').click
    expect(page).to have_content 'Deadline was successfully added!'
  end
  scenario 'An user can not set deadline for already completed task' do
    @todo_list.tasks.create!(desc: "new task", priority: 1, completed: true)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-exclamation-sign#choose_deadline').click
    expect(page).to have_content "Can't change deadline in already completed task!"
  end
end