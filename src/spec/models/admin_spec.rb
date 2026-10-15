require 'rails_helper'

RSpec.describe "Admin user", type: :model do
  it "verifies admin flag behavior on user" do
    admin_user = User.new(name: "Admin User", username: "admin_user", email: "admin_user@test.com", password: "password", admin: true)
    regular_user = User.new(name: "Regular User", username: "regular_user", email: "regular_user@test.com", password: "password", admin: false)

    expect(admin_user.admin?).to be true
    expect(regular_user.admin?).to be false
  end
end

