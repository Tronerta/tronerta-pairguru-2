class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :movie_id
end