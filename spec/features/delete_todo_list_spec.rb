require 'spec_helper'
require 'features_spec_helper'

feature "Delete TodoList", :js => true do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    login_as(user)
  end
  scenario 'An user deletes todo_list successfully' do
    user.todo_lists.create!(name: "New name")
    visit root_path
    page.execute_script('$(".bartext").trigger("mouseover")')
    page.find('.delproject').click
    click_on('OK')
    expect(page).to have_content 'Todo list was successfully deleted!'
    expect(page).to_not have_content 'New name'
  end
end