# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created along side the database with db:setup).

if Rails.env.development?
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

  users = {}
  urange = (1..2)
  urange.each do |num|
    u = User.create(:username => "tuser#{num}", :name => "another#{num} user#{num}", :password => "#{num}")
    u.save
    p u

    users[num] = u
  end

  groups = {}
  grange = (1..3)
  grange.each do |num|
    g = Group.create(:name => "group#{num}")
    g.save
    p g

    groups[num] = g
  end

  dancers = {}
  drange = (1..9)
  drange.each do |num|
    d = Dancer.create(:name => "dance#{num} person#{num}", :group_id => groups[Random.rand(grange)].id)
    d.save
    p d

    dancers[num] = d
  end

  (1..22).each do |num|
    scores = gen_scores

    total = ScoresHelper.total_score(scores)
    scores[:total] = total

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

  JSON.load(File.open(file))
end
