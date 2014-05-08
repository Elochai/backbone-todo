require 'spec_helper'

feature "Delete TodoList", :js => true do
  given!(:user) { FactoryGirl.create :user }
  given!(:todo_list) { FactoryGirl.create :todo_list, user_id: user.id }
  before(:each) do
    login_as(user)
  end
  scenario 'An user deletes todo_list successfully' do
    visit root_path
    page.execute_script('$(".bartext").trigger("mouseover")')
    page.find('.delproject').click
    click_on('OK')
    expect(page).to have_content 'Todo list was successfully deleted!'
    expect(page).to_not have_content "#{todo_list.name}"
  end
end