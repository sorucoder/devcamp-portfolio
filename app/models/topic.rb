class Topic < ApplicationRecord
  validates :title, presence: true, uniqueness: { message: "already matches an existing topic" }

  has_many :blogs

  def self.with_blogs
    includes(:blogs).where.not(blogs: { id: nil })
  end
end
