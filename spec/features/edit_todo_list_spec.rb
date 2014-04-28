require 'spec_helper'
require 'features_spec_helper'

feature "Edit TodoList", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
    user.todo_lists.create!(name: "New name")
    visit root_path
    page.execute_script('$(".bartext").trigger("mouseover")')
    page.find('.editproject').click
  end
  scenario 'An user edits todo_list successfully with valid data' do
    within '.edit_todo_list' do
      page.find('.todo_list_edit_input').set("Updated name")
    end
    page.find('.todo_list_edit_input').native.send_keys(:return)
    expect(page).to have_content 'Todo list was successfully updated!'
    expect(page).to have_content 'Updated name'
    expect(page).to_not have_content 'New name'
  end
  scenario 'An user can not edit todo_list with invalid data' do
    within '.edit_todo_list' do
      page.find('.todo_list_edit_input').set("")
    end
    page.find('.todo_list_edit_input').native.send_keys(:return)
    expect(page).to have_content 'Todo list name should not be empty!'
    expect(page).to_not have_content 'Updated name'
  end
end