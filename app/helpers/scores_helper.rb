module ScoresHelper
  def self.top_scorer(group)
    scores = {}
    group.dancers.each do |dancer|
      scores[dancer.name] = average(dancer.scores.map { |s| s.total })
    end
    name = scores.sort_by { |k,v| v }.reverse.first[0]

    name
  end

  def self.average(totals)
    avg = totals.inject { |sum, el| sum + el }.to_f / totals.length
    '%.2f' % avg
  end

  def self.total_score(scores)
    scores_dup = scores.clone
    violation = scores_dup.delete(:violation)
    scores_dup.values.reduce(:+) - violation
  end
end
