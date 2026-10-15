require 'rails_helper'

RSpec.describe "layouts/application.html.erb", type: :view do
  before do
    @title = "Test Page"
    @header = "Test Header"
  end

  context "when user is not logged in" do
    it "renders navbar with brand, me-auto left list, and ms-auto login link on the right" do
      render template: "layouts/application"

      expect(rendered).to have_css("meta[name='viewport'][content='width=device-width, initial-scale=1']", visible: false)
      expect(rendered).to have_css("nav.navbar .container-fluid")
      expect(rendered).to have_link("Home", href: root_path)
      expect(rendered).to have_css("ul.navbar-nav.me-auto")
      expect(rendered).to have_css("ul.navbar-nav.ms-auto")
      expect(rendered).to have_link("Login", href: login_path)
      expect(rendered).to have_css(".container h1", text: "Test Header")
    end
  end

  context "when user is logged in as regular user" do
    before do
      session[:logged_in] = true
      session[:user_id] = "user-123"
      assign(:current_user, double("User", name: "Dancer User", admin?: false))
    end

    it "renders navigation items and user name with logout link in ms-auto right menu" do
      render template: "layouts/application"

      expect(rendered).to have_link("Groups", href: groups_path)
      expect(rendered).to have_link("Dancers", href: dancers_path)
      expect(rendered).to have_link("Scores", href: scores_path)
      expect(rendered).not_to have_link("Users", href: users_path)
      expect(rendered).not_to have_link("Admin", href: admin_index_path)

      expect(rendered).to have_css("ul.navbar-nav.ms-auto")
      expect(rendered).to have_link("Dancer User", href: user_path("user-123"))
      expect(rendered).to have_link("Logout", href: logout_path)
    end
  end

  context "when user is logged in as admin" do
    before do
      session[:logged_in] = true
      session[:user_id] = "admin-123"
      assign(:current_user, double("User", name: "Admin Boss", admin?: true))
    end

    it "renders admin navigation items along with logout on the right" do
      render template: "layouts/application"

      expect(rendered).to have_link("Users", href: users_path)
      expect(rendered).to have_link("Admin", href: admin_index_path)
      expect(rendered).to have_link("Admin Boss", href: user_path("admin-123"))
      expect(rendered).to have_link("Logout", href: logout_path)
    end
  end

  describe "footer" do
    it "renders footer with app version when version is present" do
      allow(view).to receive(:app_version).and_return("26.29.1")
      render template: "layouts/application"

      expect(rendered).to have_css("footer")
      expect(rendered).to have_css("footer", text: "26.29.1")
    end

    it "renders footer without version text when app_version is nil" do
      allow(view).to receive(:app_version).and_return(nil)
      render template: "layouts/application"

      expect(rendered).to have_css("footer")
      expect(rendered).not_to have_css("footer span.text-muted")
    end
  end
end
