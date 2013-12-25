require 'spec_helper'

describe "ideas/index" do
  before(:each) do
    assign(:ideas, [
      stub_model(Idea,
        :title => "Title",
        :description => "MyText"
      ),
      stub_model(Idea,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of ideas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
