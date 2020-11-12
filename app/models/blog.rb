class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :body, :topic_id

  belongs_to :topic

  has_many :comments, dependent: :destroy

  acts_as_votable

  def self.recent
    order("created_at DESC")
  end

  def self.by_topic(topic_id)
    where(topic_id: topic_id)
  end
end
