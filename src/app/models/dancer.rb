class Dancer < ApplicationRecord
  validates :name, presence: true
  validates :performance_order, numericality: true
  validates :group, presence: true

  belongs_to :group

  has_many :scores
end
