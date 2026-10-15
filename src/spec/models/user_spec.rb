require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: "Test User", username: "testuser", email: "test@example.com", password: "password", admin: false) }
  let(:user_without_name) { User.new(name: nil, username: "testuser", email: "test@example.com", password: "password", admin: false) }
  let(:user_without_username) { User.new(name: "Test User", username: nil, email: "test@example.com", password: "password", admin: false) }

  describe "user model validations" do
    it "is valid with all required fields" do
      expect(user).to be_valid
    end

    it "is not valid if name is missing" do
      expect(user_without_name.save).to eq(false)
    end

    it "is not valid if username is missing" do
      expect(user_without_username.save).to eq(false)
    end
  end

  describe "uuid primary key" do
    it "automatically generates a UUID for id on save" do
      user.save!
      expect(user.id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
    end
  end
end
