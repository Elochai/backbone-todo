require 'spec_helper'

feature "Create TodoList", :js => true do
  given!(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    visit root_path
    click_on "new_todo_list"
  end
  scenario 'An user creates new todo_list successfully with valid data' do
    fill_in 'alertify-text', with: 'New name'
    click_button 'OK'
    expect(page).to have_content 'New name'
    expect(page).to have_content 'Todo list was successfully created!'
  end
  scenario 'An user can not create new todo_list with invalid data' do
    fill_in 'alertify-text', with: ''
    click_button 'OK'
    expect(page).to have_content 'Todo list name should not be empty!'
  end
end