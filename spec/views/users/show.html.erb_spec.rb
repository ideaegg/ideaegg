require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :password_digest => "Password Digest",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #expect(rendered).to match(/Name/)
    #expect(rendered).to match(/Password Digest/)
    #expect(rendered).to match(/Email/)
  end
end
