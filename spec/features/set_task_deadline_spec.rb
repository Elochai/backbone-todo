require 'spec_helper'
require 'features_spec_helper'

feature "Set task deadline", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    todo_list = user.todo_lists.create!(name: "New name")
    todo_list.tasks.create!(desc: "new task", priority: 1)
    visit root_path
    page.execute_script('$("#task_desc").trigger("mouseover")')
    page.find('.icon-exclamation-sign#choose_deadline').click
  end
  scenario 'An user sets task deadline successfully' do
    page.find('#set_deadline').click
    expect(page).to have_content 'Deadline was successfully added!'
  end
end