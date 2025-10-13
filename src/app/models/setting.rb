# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  # Define your fields
  field :public_scores, type: :boolean, default: false
  field :app_name, default: "AATF", type: :string
end
