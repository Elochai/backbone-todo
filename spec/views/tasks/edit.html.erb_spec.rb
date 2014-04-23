require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :desc => "MyString",
      :completed => false,
      :priority => 1
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "input#task_desc[name=?]", "task[desc]"
      assert_select "input#task_completed[name=?]", "task[completed]"
      assert_select "input#task_priority[name=?]", "task[priority]"
    end
  end
end
