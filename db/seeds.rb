# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

(1..10).each do |num|
  score_percentages = {
    :theme => 20,
    :choreography => 15,
    :technique => 15,
    :presentation => 20,
    :costume => 15,
    :music => 15,
    :violation => 15
  }
  scores = {}
  score_percentages.each do |c,p|
    r = Random.rand(0..p)
    scores[c] = r
  end

  rand = Random.rand(0...973822)

  g = Group.create(:name => "#{rand}group")
  g.save
  p g

  u = User.create(:username => "tu#{rand}", :name => "test#{rand} user#{rand}", :password => "#{rand}#{rand}")
  p u

  d = Dancer.create(:name => "dance#{rand} person#{rand}", :group_id => g.id)
  p d

  scores[:dancer_id] = d.id
  s = Score.create(scores)
  s.save
  p s
end
