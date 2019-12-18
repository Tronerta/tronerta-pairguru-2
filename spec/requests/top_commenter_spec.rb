require "rails_helper"

describe "Top commenters request", type: :request do
  describe "top commenters list" do
    let!(:comments) { FactoryBot.create_list(:comment, 5) }

    it "displays list of users" do
      visit "/top_commenters"
      expect(page).to have_selector("table")
      expect(page).to have_selector("tr")
    end

    it "does not count old comments" do
      c = comments.sample
      c.created_at = 10.days.ago
      expect{c.save}.to change(c.user.comments.recents, :count).by(-1)
    end
  end
end