module ScoresHelper
  NIL_SCORE = -10000000000

  def self.top_scorer(group)
    scores = {}
    group.dancers.each do |dancer|
      scores[dancer.name] = average(dancer.scores.map { |s| s.total })
    end
    if scores.length > 0
      scores.sort_by { |k,v| v }.reverse.first[0]
    else
      "None currently"
    end
  end

  def self.average(totals)
      p "-="*22
      p totals.inject { |sum, el| sum + el }
      p totals.length
      p "-="*22
    if totals.length > 0
      '%.2f' % (totals.inject { |sum, el| sum + el }).to_f / totals.length.to_f
    else
      "N/A"
    end
  end

  def self.total_score(scores)
    scores_dup = scores.clone
    violation = scores_dup.delete(:violation)
    scores_dup.values.reduce(:+) - violation
  end

  def self.convert_score(score)
    if score == NIL_SCORE
      "N/A"
    else
      score
    end
  end
end
