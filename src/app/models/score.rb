class Score < ApplicationRecord
  validates :theme, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 20 }
  validates :choreography, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 15 }
  validates :technique, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 15 }
  validates :presentation, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 20 }
  validates :costume, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 20 }
  validates :music, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 15 }

  validates :total, numericality: { greater_than_or_equal_to: -15, less_than_or_equal_to: 100 }

  validates :violation, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 15 }

  belongs_to :dancer
  belongs_to :user
end
