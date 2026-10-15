require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    it "returns default title without extra_title" do
      expect(helper.page_title).to eq("#{Setting.app_name} Dance Scorer")
    end

    it "appends extra_title when provided" do
      expect(helper.page_title("Leaderboard")).to eq("#{Setting.app_name} Dance Scorer - Leaderboard")
    end
  end
end

