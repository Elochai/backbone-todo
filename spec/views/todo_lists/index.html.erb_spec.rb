require 'spec_helper'

describe "todo_lists/index" do
  before(:each) do
    assign(:todo_lists, [
      stub_model(TodoList,
        :name => "Name"
      ),
      stub_model(TodoList,
        :name => "Name"
      )
    ])
  end

  it "renders a list of todo_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
