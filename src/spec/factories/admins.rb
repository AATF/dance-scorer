FactoryBot.define do
  factory :admin, class: 'User' do
    name { "Admin User" }
    username { "admin_user" }
    email { "admin_user@example.com" }
    password { "password123" }
    admin { true }
  end
end

