# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

(1..10).each do |num|
  rand = Random.rand(2...973822)

  g = Group.create(:name => "#{rand}group")

  User.create(:first_name => "test#{rand}", :last_name => "user#{rand}", :password => "#{rand}#{rand}")

  Dancer.create(:first_name => "test#{rand}", :last_name => "user#{rand}", :score => rand, :group_id => g.id)
end
