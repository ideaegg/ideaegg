require 'spec_helper'

describe User do
  describe 'Assoications' do
    it { should have_many(:authentications) }
  end
end
