module ScoresHelper
  def self.top_scorer(group)
    scores = {}
    group.dancers.each do |dancer|
      scores[dancer.name] = average(dancer.scores.map { |s| s.total })
    end
    if scores.length > 0
      name = scores.sort_by { |k,v| v }.reverse.first[0]
    else
      name = "None currently"
    end

    name
  end

  def self.average(totals)
    totals.inject { |sum, el| sum + el } / totals.length
  end

  def self.total_score(scores)
    scores_dup = scores.clone
    violation = scores_dup.delete(:violation)
    scores_dup.values.reduce(:+) - violation
  end

  def self.convert_score(score)
    if score == -1
      "N/A"
    else
      score
    end
  end
end
