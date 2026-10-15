require 'rails_helper'
require 'spec_helper'

RSpec.describe Score, type: :model do
  let(:group) { Group.create!(name: "Test Group") }
  let(:dancer) { Dancer.create!(name: "Test Dancer", dance_name: "Test Dance", performance_order: 1, group: group) }
  let(:user) { User.create!(name: "Judge 1", username: "judge1", email: "judge1@example.com", password: "password", admin: false) }
  let(:score) do
    Score.new(
      dancer: dancer,
      user: user,
      theme: 15,
      choreography: 12,
      technique: 13,
      presentation: 16,
      costume: 14,
      music: 12,
      violation: 0,
      total: 82
    )
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(score).to be_valid
    end

    it "is invalid without a dancer" do
      score.dancer = nil
      expect(score).not_to be_valid
    end

    it "is invalid without a user" do
      score.user = nil
      expect(score).not_to be_valid
    end
  end

  describe "uuid primary key and foreign keys" do
    it "automatically generates a UUID for id on save and stores UUID foreign keys" do
      score.save!
      expect(score.id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
      expect(score.dancer_id).to eq(dancer.id)
      expect(score.dancer_id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
      expect(score.user_id).to eq(user.id)
      expect(score.user_id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
    end
  end
end
