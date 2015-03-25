class List < ActiveRecord::Base
	extend FriendlyId

	validates :title, presence: true
	validates :user_id, presence: true
	belongs_to :user
	has_many :tasks

	friendly_id :title, :use => :scoped, :scope => :user
end
