require 'spec_helper'

describe Like do
  let(:like) { Fabricate(:like) }

  subject { Fabricate(:like) }

  describe 'Respand to' do
    it { should respond_to(:user) }
    it { should respond_to(:idea) }
  end
end
