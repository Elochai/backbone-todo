require 'spec_helper'

feature "Edit TodoList", :js => true do
  given!(:user) { FactoryGirl.create :user }
  given!(:todo_list) { FactoryGirl.create :todo_list, user_id: user.id }
  before(:each) do
    login_as(user)
    visit root_path
    find(".bartext").trigger('mouseover')
    page.find('.editproject').click
  end
  scenario 'An user edits todo_list successfully with valid data' do
    page.find('#input_edited_name').set("Updated name")
    page.find("#update_todo_list").click
    expect(page).to have_content 'Todo list was successfully updated!'
    expect(page).to have_content 'Updated name'
    expect(page).to_not have_content "#{todo_list.name}"
  end
  scenario 'An user can not edit todo_list with invalid data' do
    page.find('#input_edited_name').set("")
    page.find("#update_todo_list").click
    expect(page).to have_content 'Todo list name should not be empty!'
    expect(page).to_not have_content 'Updated name'
  end
end