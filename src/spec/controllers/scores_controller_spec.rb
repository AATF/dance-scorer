require 'rails_helper'

RSpec.describe ScoresController, type: :controller do
  let(:group) { Group.create!(name: "Test Group") }
  let(:dancer) { Dancer.create!(name: "Test Dancer", dance_name: "Test Dance", performance_order: 1, group: group) }
  let(:user) { User.create!(name: "Judge", username: "judge_#{SecureRandom.hex(4)}", email: "judge_#{SecureRandom.hex(4)}@test.com", password: "password", admin: false) }
  let!(:score) do
    Score.create!(
      dancer: dancer,
      user: user,
      theme: 10,
      choreography: 10,
      technique: 10,
      presentation: 10,
      costume: 10,
      music: 10,
      violation: 0,
      total: 60
    )
  end

  before do
    session[:user_id] = user.id
  end

  describe "PUT/PATCH #update" do
    it "updates score successfully with UUID id" do
      patch :update, params: {
        id: score.id,
        score: {
          dancer_id: dancer.id,
          theme: 15,
          choreography: 12,
          technique: 12,
          presentation: 15,
          costume: 12,
          music: 12,
          violation: 0
        }
      }
      expect(response).to redirect_to(scores_path)
      score.reload
      expect(score.theme).to eq(15.0)
    end
  end
end
