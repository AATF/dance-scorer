# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongroups[Random.rand(range)].ide the database with db:setup).

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

  scores
end

u1 = User.create(:username => "tu1", :name => "test1 user1", :password => "1")
u1.save
p u1
u2 = User.create(:username => "tuser2", :name => "another2 user2", :password => "2")
u2.save
p u2

groups = {}
grange = (1..3)
grange.each do |num|
  g = Group.create(:name => "group#{num}")
  g.save
  p g

  groups[num] = g
end

dancers = {}
drange = (1..5)
drange.each do |num|
  d = Dancer.create(:name => "dance#{num} person#{num}", :group_id => groups[Random.rand(grange)].id)
  d.save
  p d

  dancers[num] = d
end

(1..10).each do |num|
  scores1 = gen_scores
  scores1[:dancer_id] = dancers[Random.rand(drange)].id
  scores1[:user_id] = u1.id
  s1 = Score.create(scores1)
  s1.save
  p s1

  scores2 = gen_scores
  scores2[:dancer_id] = dancers[Random.rand(drange)].id
  scores2[:user_id] = u1.id
  s2 = Score.create(scores2)
  p s2

  scores3 = gen_scores
  scores3[:dancer_id] = dancers[Random.rand(drange)].id
  scores3[:user_id] = u2.id
  s3 = Score.create(scores2)
  s3.save
  p s3

  scores4 = gen_scores
  scores4[:dancer_id] = dancers[Random.rand(drange)].id
  scores4[:user_id] = u2.id
  s4 = Score.create(scores4)
  p s4
end
