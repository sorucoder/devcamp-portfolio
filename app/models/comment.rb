class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, presence: true, length: { minimum: 5, maximum: 1000 }

  acts_as_votable

  after_create_commit { CommentBroadcastJob.perform_later(self) }
end
