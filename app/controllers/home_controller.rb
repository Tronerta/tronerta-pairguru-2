class HomeController < ApplicationController
  def welcome; end


  def top_commenters
    @top_commenters = User.joins(:comments)
                          .merge(Comment.recents)
                          .group("comments.user_id")
                          .order("count(comments.user_id) DESC")
                          .limit(10)
  end
end
