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

  describe "GET #index" do
    let(:dancer2) { Dancer.create!(name: "Second Dancer", dance_name: "Second Dance", performance_order: 2, group: group) }
    let(:user2) { User.create!(name: "Judge 2", username: "judge_#{SecureRandom.hex(4)}", email: "judge_#{SecureRandom.hex(4)}@test.com", password: "password", admin: false) }
    let!(:score2) do
      Score.create!(
        dancer: dancer2,
        user: user2,
        theme: 12,
        choreography: 12,
        technique: 12,
        presentation: 12,
        costume: 12,
        music: 12,
        violation: 0,
        total: 72
      )
    end

    context "when logged in as admin" do
      before do
        session[:admin] = true
      end

      it "returns all scores ordered by dancer_id and user_id" do
        get :index
        expect(response).to be_successful
        expect(controller.instance_variable_get(:@scores)).to eq(Score.order(:dancer_id, :user_id).to_a)
      end
    end

    context "when logged in as normal judge" do
      it "returns only scores for the current user" do
        get :index
        expect(response).to be_successful
        expect(controller.instance_variable_get(:@scores)).to eq([score])
      end
    end

    context "when not logged in" do
      before do
        session[:user_id] = nil
      end

      it "redirects to login path" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
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
