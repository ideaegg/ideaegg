#require 'spec_helper'

#describe "User pages" do

  #subject { page }

  #describe "profile page" do
    #let(:user) { FactoryGirl.create(:user) }
    #let!(:i1) { FactoryGirl.create(:idea, user: user, title: "Hello", description: "Lorem ipsum") }
    #let!(:i2) { FactoryGirl.create(:idea, user: user, title: "Hello", description: "Lorem ipsum") }

    #before { visit user_path(user) }

    #it { should have_content(user.name) }
    #it { should have_title(user.name) }

    #describe "ideas" do
      #it { should have_content(i1.title) }
      #it { should have_content(i2.title) }
      #it { should have_content(user.ideas.count) }
    #end
  #end
#end
