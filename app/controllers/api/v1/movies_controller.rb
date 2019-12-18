module Api
  module V1
    class MoviesController < ApplicationController
      respond_to :json

      def index
        @movies = Movie.all.select("id, title")
        render json: @movies, status: :ok
      end

      def show
        @movie = Movie.find(params[:id])
        render json: @movie, status: :ok
      end
    end
  end
end