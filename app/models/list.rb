class List < ActiveRecord::Base
	extend FriendlyId

	validates :title, presence: true
	validates :user_id, presence: true
	belongs_to :user
	has_many :tasks
end
