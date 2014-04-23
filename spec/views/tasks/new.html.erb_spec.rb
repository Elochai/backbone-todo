require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :desc => "MyString",
      :completed => false,
      :priority => 1
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input#task_desc[name=?]", "task[desc]"
      assert_select "input#task_completed[name=?]", "task[completed]"
      assert_select "input#task_priority[name=?]", "task[priority]"
    end
  end
end
