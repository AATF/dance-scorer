class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :generate_uuid

  private

  def generate_uuid
    self.id ||= SecureRandom.uuid
  end
end
