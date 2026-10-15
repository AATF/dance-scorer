require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #new" do
    render_views

    it "returns http success and renders password reset form" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Forgot your password?")
      expect(response.body).to include("Send me reset password instructions")
    end
  end

  describe "POST #create" do
    let!(:user) { User.create!(name: "Test User", username: "testuser", email: "test@example.com", password: "password", admin: false) }

    it "generates reset password email with valid host url" do
      expect {
        post :create, params: { user: { email: user.email } }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(response).to redirect_to(new_session_path(:user))
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to include(user.email)
      expect(mail.body.encoded).to include("Change my password")
      expect(mail.body.encoded).to include("http://localhost:3000/users/password/edit?reset_password_token=")
    end
  end
end
