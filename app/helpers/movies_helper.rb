module MoviesHelper

  def get_movie_data(url, title)
    title = URI.encode(title)
    response = RestClient.get("#{url}api/v1/movies/#{title}")
    response = JSON.parse(response)
    response["data"]["attributes"]
  end
end