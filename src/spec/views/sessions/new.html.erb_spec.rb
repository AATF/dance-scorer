require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :view do
  it "renders the login form and link to password reset" do
    render

    expect(rendered).to have_selector("form[action='#{sessions_path}']")
    expect(rendered).to have_selector("input[name='session[username]']")
    expect(rendered).to have_selector("input[name='session[password]']")
    expect(rendered).to have_link("Forgot your password?", href: new_user_password_path)
  end
end
