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
end
