require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:movie) { FactoryBot.create(:movie) }
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  let(:valid_attributes) {
    {
        body: "Some text",
        movie_id: movie.id,
        user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
        body: 123,
        movie_id: 'a',
        user_id: nil
    }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, params: { movie_id: movie.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the movie" do
        post :create, params: { movie_id: movie.id, comment: valid_attributes }
        expect(response).to redirect_to(movie)
      end
    end

    context "with invalid params" do
      it "returns a non success response" do
        sign_in nil
        post :create, params: { movie_id: movie.id, comment: invalid_attributes }
        expect(response).not_to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = Comment.create valid_attributes
      expect {
        delete :destroy, params: { id: comment.id, movie_id: movie.id }
      }.to change(movie.comments, :count).by(-1)
    end

    it "redirects to the movie" do
      comment = Comment.create valid_attributes
      delete :destroy, params: { id: comment.to_param, movie_id: movie.id }
      expect(response).to redirect_to(movie)
    end
  end

end