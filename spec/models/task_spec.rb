require 'spec_helper'

describe Task do
	describe 'validations' do
		it { should validate_presence_of :title }
		it { should belong_to :list }
		it { should validate_presence_of :list_id }
	end
end
