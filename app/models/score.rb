class Score < ApplicationRecord
  validates :theme, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  validates :choreography, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 15 }
  validates :technique, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 15 }
  validates :presentation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  validates :costume, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  validates :music, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 15 }

  validates :total, numericality: { only_integer: true, greater_than_or_equal_to: -15, less_than_or_equal_to: 100 }

  validates :violation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 15 }

  belongs_to :dancer
  belongs_to :user
end
