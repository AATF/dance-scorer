require 'rails_helper'

RSpec.describe DancersController, type: :controller do
  render_views

  let(:group_b) { Group.create!(name: "B Group") }
  let(:group_a) { Group.create!(name: "A Group") }
  let!(:dancer1) { Dancer.create!(name: "Dancer 1", dance_name: "Dance 1", performance_order: 2, group: group_b) }
  let!(:dancer2) { Dancer.create!(name: "Dancer 2", dance_name: "Dance 2", performance_order: 1, group: group_b) }
  let!(:dancer3) { Dancer.create!(name: "Dancer 3", dance_name: "Dance 3", performance_order: 1, group: group_a) }

  let(:regular_user) { User.create!(name: "Regular", username: "user_#{SecureRandom.hex(4)}", email: "user_#{SecureRandom.hex(4)}@test.com", password: "password", admin: false) }
  let(:admin_user) { User.create!(name: "Admin", username: "admin_#{SecureRandom.hex(4)}", email: "admin_#{SecureRandom.hex(4)}@test.com", password: "password", admin: true) }

  describe "GET #index" do
    context "when not logged in" do
      it "redirects to login_path" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

    context "when logged in" do
      before do
        session[:user_id] = regular_user.id
      end

      it "renders index successfully and lists dancers ordered by group then performance_order" do
        get :index
        expect(response).to be_successful
        expect(response.body).to include("Dancer 1")
        expect(response.body).to include("Dancer 2")
        expect(response.body).to include("Dancer 3")

        # Dancer 3 (group A, order 1) should appear before Dancer 2 (group B, order 1), which appears before Dancer 1 (group B, order 2)
        pos3 = response.body.index("Dancer 3")
        pos2 = response.body.index("Dancer 2")
        pos1 = response.body.index("Dancer 1")
        expect(pos3).to be < pos2
        expect(pos2).to be < pos1
      end
    end
  end

  describe "GET #show" do
    before do
      session[:user_id] = regular_user.id
    end

    it "renders dancer details" do
      get :show, params: { id: dancer1.id }
      expect(response).to be_successful
      expect(response.body).to include("Dancer 1")
      expect(response.body).to include("Dance 1")
    end
  end

  describe "GET #new" do
    context "when regular user" do
      before do
        session[:user_id] = regular_user.id
      end

      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin user" do
      before do
        session[:user_id] = admin_user.id
      end

      it "renders new template for admin" do
        get :new
        expect(response).to be_successful
        expect(response.body).to include("New Dancer")
      end
    end
  end

  describe "POST #create" do
    before do
      session[:user_id] = regular_user.id
    end

    it "creates dancer and redirects to dancers_path" do
      expect {
        post :create, params: {
          dancer: {
            name: "Brand New Dancer",
            dance_name: "Brand New Dance",
            performance_order: 3,
            group_id: group_a.id
          }
        }
      }.to change(Dancer, :count).by(1)

      expect(response).to redirect_to(dancers_path)
      created = Dancer.find_by(name: "Brand New Dancer")
      expect(created).not_to be_nil
      expect(created.dance_name).to eq("Brand New Dance")
      expect(created.performance_order).to eq(3)
      expect(created.group_id).to eq(group_a.id)
    end
  end

  describe "GET #edit" do
    context "when regular user" do
      before do
        session[:user_id] = regular_user.id
      end

      it "redirects to root_path" do
        get :edit, params: { id: dancer1.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin user" do
      before do
        session[:user_id] = admin_user.id
      end

      it "renders edit template for admin" do
        get :edit, params: { id: dancer1.id }
        expect(response).to be_successful
        expect(response.body).to include("Edit Dancer")
        expect(response.body).to include(dancer1.name)
      end
    end
  end

  describe "PUT/PATCH #update" do
    before do
      session[:user_id] = regular_user.id
    end

    it "updates dancer and redirects to dancer_path" do
      patch :update, params: {
        id: dancer1.id,
        dancer: {
          name: "Updated Name",
          dance_name: "Updated Dance",
          performance_order: 5,
          group_id: group_a.id
        }
      }

      expect(response).to redirect_to(dancer_path)
      dancer1.reload
      expect(dancer1.name).to eq("Updated Name")
      expect(dancer1.dance_name).to eq("Updated Dance")
      expect(dancer1.performance_order).to eq(5)
      expect(dancer1.group_id).to eq(group_a.id)
    end
  end
end
