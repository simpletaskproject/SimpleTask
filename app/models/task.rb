class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :title, uniqueness: true
	validates :list_id, presence: true
	belongs_to :list
end
