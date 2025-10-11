require 'rails_helper'
require 'spec_helper'

RSpec.describe Contest, type: :model do
  let(:contest) { Contest.new(title: "title") }
  let(:contest_without_required_fields) {Contest.new(title: nil)}

  describe "contest model validations" do
    it "contest is valid with all required fields" do
      expect(contest.title).to eq("title")
    end

    it "contest is not valid if title is missing" do
      expect(contest_without_required_fields.save).to eq(false)
    end

  end
end
