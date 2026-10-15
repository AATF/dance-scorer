require 'rails_helper'
require 'spec_helper'

RSpec.describe Group, type: :model do
  let(:group) { Group.new(name: "Test Group") }
  let(:group_without_name) { Group.new(name: nil) }

  describe "group model validations" do
    it "is valid with all required fields" do
      expect(group.name).to eq("Test Group")
      expect(group).to be_valid
    end

    it "is not valid if name is missing" do
      expect(group_without_name.save).to eq(false)
    end
  end

  describe "uuid primary key" do
    it "automatically generates a UUID for id on save" do
      group.save!
      expect(group.id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
    end
  end
end
