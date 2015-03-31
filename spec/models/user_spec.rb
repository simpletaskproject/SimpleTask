require 'spec_helper'

describe User do
  describe 'validation' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should have_many :lists }
    it { should have_many :tasks }
  end
end
