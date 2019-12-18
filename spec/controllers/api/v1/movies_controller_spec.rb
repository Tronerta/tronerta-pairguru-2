require "rails_helper"

RSpec.describe Api::V1::MoviesController, type: :controller do
  describe "GET #index" do
    let!(:movies) { create_list(:movie, 20)}

    before do
      get :index
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "returns all movies" do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it "returns correct keys" do
      json = JSON.parse(response.body)[0]
      expect(json["title"]).not_to be_nil
    end

  end

  describe "GET #show" do
    let!(:movie) { FactoryBot.create(:movie)}

    before do
      get :show, params: { id: movie.id }
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "returns right movie data" do
      json = JSON.parse(response.body)
      expect(json["title"]).to eq(movie.title)
      expect(json["description"]).to eq(movie.description)
      expect(json["genre_id"]).to eq(movie.genre_id)
    end

    it "returns error if bad movie id" do
      get :show, params: { id: 10000 }
      json = JSON.parse(response.body)
      expect(json["error"]).not_to be_nil
    end

  end
end