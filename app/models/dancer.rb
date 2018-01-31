class Dancer < ApplicationRecord
  validates :name, presence: true

  belongs_to :group
  has_many :scores
end
