require 'spec_helper'

describe Collection do
  let(:collection) { Fabricate(:collection) }

  subject { Fabricate(:collection) }

  describe 'Respond to' do
    it { should respond_to(:user) }
    it { should respond_to(:idea) }
  end
end
