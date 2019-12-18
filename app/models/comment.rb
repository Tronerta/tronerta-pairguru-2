class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :movie_id, uniqueness: { scope: :user_id, message: "You've already commented this movie!" }

  scope :recents, -> {
    where("comments.created_at >= ?", Time.zone.now - 7.days)
  }
end