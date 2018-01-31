# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

def gen_scores
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
end

(1..10).each do |num|
  g = Group.create(:name => "group#{num}")
  g.save
  p g

  u1 = User.create(:username => "tu#{num}", :name => "test#{num} user#{num}", :password => num.to_s)
  u1.save
  p u1
  u2 = User.create(:username => "tuser#{num}", :name => "another#{num} user#{num}", :password => num.to_s)
  u2.save
  p u2

  d1 = Dancer.create(:name => "dance#{num} person#{num}", :group_id => g.id)
  d1.save
  p d1
  d2 = Dancer.create(:name => "another#{num} person#{num}", :group_id => g.id)
  d2.save
  p d2

  scores1 = gen_scores
  scores1[:dancer_id] = d.id
  scores1[:user_id] = u1.id
  s1 = Score.create(scores1)
  s1.save
  p s1
  scores2 = gen_scores
  scores2[:dancer_id] = d.id
  scores2[:user_id] = u2.id
  s2 = Score.create(scores2)
  p s2
end
