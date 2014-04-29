require 'spec_helper'
require 'features_spec_helper'

feature "Change task priorirty", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    todo_list = user.todo_lists.create!(name: "New name")
    @task1 = todo_list.tasks.create!(desc: "task 1", priority: 1)
    @task2 = todo_list.tasks.create!(desc: "task 2", priority: 2)
    visit root_path
  end
  scenario 'An user increases priority of the task successfully' do
    find("#task_desc#{@task2.id}").hover
    page.find('.up').click  
    page.should have_selector('tbody tr:nth-child(1)', text: 'task 2')
    page.should have_selector('tbody tr:nth-child(2)', text: 'task 1')
  end
  scenario 'An user decreases priority of the task successfully' do
    find("#task_desc#{@task1.id}").hover
    page.find('.down').click  
    page.should have_selector('tbody tr:nth-child(1)', text: 'task 2')
    page.should have_selector('tbody tr:nth-child(2)', text: 'task 1')
  end
end