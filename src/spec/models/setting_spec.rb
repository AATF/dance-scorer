require 'rails_helper'
require 'spec_helper'

RSpec.describe Setting, type: :model do
  describe "uuid primary key" do
    it "automatically generates a UUID for id on create" do
      setting = Setting.create!(var: "test_uuid_setting", value: "hello")
      expect(setting.id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
    end
  end
end

