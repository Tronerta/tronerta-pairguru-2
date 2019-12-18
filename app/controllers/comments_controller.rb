class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    if current_user.comments.find_by(movie_id: @movie.id)
      redirect_to @movie, notice: "You already commented this movie"
    else
      @comment = @movie.comments.create(comment_params)
      @comment.user_id = current_user.id

      if @comment.save
        redirect_to @movie, notice: "Comment was successfully created."
      else
        redirect_to @movie, notice: "Comment was not created."
      end
    end
  end

  def destroy
    @movie = @comment.movie
    if @comment.destroy
      redirect_to @movie, notice: 'Comment was successfully destroyed.'
    else
      redirect_to @movie, notice: 'Comment was not destroyed'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body, :movie_id)
  end
end