require 'rails_helper'
require 'spec_helper'

RSpec.describe Dancer, type: :model do
  let(:group) { Group.new(name: "Test Group") }
  let(:dancer) { Dancer.new(name: "Test Dancer", dance_name: "Test Dance", performance_order: 1, group: group) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(dancer).to be_valid
    end

    it "is not valid without a name" do
      dancer.name = nil
      expect(dancer).not_to be_valid
    end

    it "is not valid without a group" do
      dancer.group = nil
      expect(dancer).not_to be_valid
    end

    it "is not valid with a non-numeric performance_order" do
      dancer.performance_order = "abc"
      expect(dancer).not_to be_valid
    end
  end
end
