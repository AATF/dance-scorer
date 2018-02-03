# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created along side the database with db:setup).

def gen_scores(prod = false)
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
    if prod
      scores[c] = 0
    else
      r = Random.rand(0..p)
      scores[c] = r
    end
  end

  total = ScoresHelper.total_score(scores)
  scores[:total] = total

  scores
end

users = {}
urange = (1..4)
urange.each do |num|
  u = User.create(:username => "judge#{num}", :name => "judge #{num}", :password => "judge#{num}", :admin => false)
  u.save
  p u

  users[num] = u
end

a = User.create(:username => "admin", :name => "admin user", :password => "admin", :admin => true)
a.save
p a

if Rails.env.development?
  groups = {}
  grange = (1..3)
  grange.each do |num|
    g = Group.create(:name => "group#{num}")
    g.save
    p g

    groups[num] = g
  end

  dancers = {}
  drange = (1..12)
  drange.each do |num|
    d = Dancer.create(:name => "dance#{num} person#{num}", :group_id => groups[Random.rand(grange)].id, :dance_name => "dance name #{num}")
    d.save
    p d

    dancers[num] = d
  end

  (1..49).each do |num|
    scores = gen_scores

    scores[:dancer_id] = dancers[Random.rand(drange)].id
    scores[:user_id] = users[Random.rand(urange)].id
    s = Score.create(scores)
    s.save
    p s
  end
end

if Rails.env.production?
  require 'json'

  file = ARGV[1]

  json = JSON.load(File.open(file))
  p json

  json.each do |group,names|
    g = Group.create(:name => group)
    g.save
    names.each do |dancer,dance|
      d = Dancer.create(:name => dancer, :group_id => g.id, :dance_name => dance, :performance_order => 1)
      d.save
      p d

      users.each do |_n,u|
        s = Score.create(gen_scores(true).merge(:dancer_id => d.id, :user_id => u.id))
        s.save
        p s
      end
    end
  end
end
