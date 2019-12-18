class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  include MoviesHelper

  def index
    @movies = Movie.all.decorate
    @url = "https://pairguru-api.herokuapp.com/"
  end

  def show
    @movie = Movie.find(params[:id])
    @url = "https://pairguru-api.herokuapp.com/"
    @data = get_movie_data(@url, @movie.title)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
