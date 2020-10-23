class Topic < ApplicationRecord
  validates :title, presence: true, uniqueness: { message: "already matches an existing topic" }

  has_many :blogs
end
