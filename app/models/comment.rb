class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :movie_id
  validates :movie_id, uniqueness: { scope: :user_id, message: "You've already commented this movie!" }
end