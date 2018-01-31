class Score < ApplicationRecord
  validates :theme, numericality: { only_integer: true }
  validates :choreography, numericality: { only_integer: true }
  validates :technique, numericality: { only_integer: true }
  validates :presentation, numericality: { only_integer: true }
  validates :costume, numericality: { only_integer: true }
  validates :music, numericality: { only_integer: true }
  validates :violation, numericality: { only_integer: true }

  belongs_to :dancer
  belongs_to :user
end
