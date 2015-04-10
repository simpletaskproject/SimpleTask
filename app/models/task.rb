class Task < ActiveRecord::Base
  validates :title, presence: true
  validates :list_id, presence: true
  belongs_to :list
  delegate :user, to: :list
  scope :today, -> { where(date: Date.today)  }

  def as_json(options={})
    super(include: { list: { only: :slug } } )
  end
end
