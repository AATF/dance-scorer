require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { User.create!(name: "Test User", username: "testuser", email: "test@example.com", password: "password123", admin: false) }

  describe "GET #new" do
    it "renders the new template when not logged in" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects to root when already logged in" do
      session[:logged_in] = true
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    it "logs in user with valid credentials and stores UUID in session" do
      post :create, params: { session: { username: "testuser", password: "password123" } }
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to eq(user.id)
      expect(session[:user_id]).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
      expect(session[:logged_in]).to be true
    end

    it "fails login with invalid credentials" do
      post :create, params: { session: { username: "testuser", password: "wrongpassword" } }
      expect(response).to redirect_to(login_path)
      expect(session[:user_id]).to be_nil
    end

    it "fails login gracefully when session params are missing" do
      post :create
      expect(response).to redirect_to(login_path)
      expect(session[:user_id]).to be_nil
    end
  end

  describe "GET/DELETE #destroy" do
    it "clears session and redirects to root" do
      session[:user_id] = user.id
      session[:logged_in] = true
      delete :destroy, params: { id: user.id }
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
