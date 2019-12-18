module Api
  module V2
    class MoviesController < ApplicationController
      respond_to :json

      def index
        @movies = Movie.all.select("id, title, genre_id")
        render json: @movies,
               include: { genre: { only: [:id, :name], methods: :number_of_movies } },
               except: :genre_id
      end

      def show
        @movie = Movie.find(params[:id])
        render json: @movie,
               include: { genre: { only: [:id, :name], methods: :number_of_movies } },
               except: :genre_id
      end
    end
  end
end