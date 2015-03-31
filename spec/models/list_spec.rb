require 'spec_helper'


describe List do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :user_id  }
    it { should belong_to :user }
    it { should have_many :tasks }
  end
end

