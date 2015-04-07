class Task < ActiveRecord::Base
  validates :title, presence: true
  validates :list_id, presence: true
  belongs_to :list
  delegate :user, to: :list
  scope :today, -> { where(date: Date.today)  }
end
