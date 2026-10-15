require 'rails_helper'

RSpec.describe ScoresHelper, type: :helper do
  describe ".average" do
    it "returns formatted average string for numbers" do
      expect(ScoresHelper.average([10.0, 20.0])).to eq("15.00")
    end

    it "returns N/A for empty array" do
      expect(ScoresHelper.average([])).to eq("N/A")
    end
  end

  describe ".total_score" do
    it "sums categories and subtracts violation" do
      scores = {
        theme: 15.0,
        choreography: 12.0,
        technique: 13.0,
        presentation: 16.0,
        costume: 14.0,
        music: 12.0,
        violation: 2.0
      }
      expect(ScoresHelper.total_score(scores)).to eq(80.0)
    end
  end

  describe ".convert_score" do
    it "returns N/A when score is NIL_SCORE" do
      expect(ScoresHelper.convert_score(ScoresHelper::NIL_SCORE)).to eq("N/A")
    end

    it "returns the score when not NIL_SCORE" do
      expect(ScoresHelper.convert_score(85.5)).to eq(85.5)
    end
  end

  describe ".top_scorer" do
    it "returns None currently when group has no dancers" do
      group = Group.create!(name: "Empty Group")
      expect(ScoresHelper.top_scorer(group)).to eq("None currently")
    end

    it "returns the dancer name with the highest score" do
      group = Group.create!(name: "Dance Troupe")
      dancer1 = Dancer.create!(name: "Alice", dance_name: "Dance A", performance_order: 1, group: group)
      dancer2 = Dancer.create!(name: "Bob", dance_name: "Dance B", performance_order: 2, group: group)
      user = User.create!(name: "Judge", username: "judge_top", email: "judge_top@test.com", password: "password", admin: false)

      Score.create!(dancer: dancer1, user: user, theme: 10, choreography: 10, technique: 10, presentation: 10, costume: 10, music: 10, violation: 0, total: 60.0)
      Score.create!(dancer: dancer2, user: user, theme: 15, choreography: 15, technique: 15, presentation: 15, costume: 15, music: 15, violation: 0, total: 90.0)

      expect(ScoresHelper.top_scorer(group)).to eq("Bob")
    end
  end
end

