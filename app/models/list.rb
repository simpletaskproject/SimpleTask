class List < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :title, :scope => :user
  belongs_to :user
  has_many :tasks, dependent: :destroy

  friendly_id :title, :use => [:scoped, :slugged], :scope => :user_id

  def as_json(options={})
    super(:include => :tasks)
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

end
