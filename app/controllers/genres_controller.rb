class GenresController < ApplicationController

  def index
    @genres = Genre.all.decorate
  end

  def movies
    @genre = Genre.find(params[:id]).decorate
    @url = "https://pairguru-api.herokuapp.com/"
  end
end
