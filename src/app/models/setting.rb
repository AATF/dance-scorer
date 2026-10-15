# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  before_create :generate_uuid

  # Define your fields
  field :public_scores, type: :boolean, default: false
  field :app_name, default: "AATF", type: :string

  private

  def generate_uuid
    self.id ||= SecureRandom.uuid
  end
end
