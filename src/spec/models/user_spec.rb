require 'rails_helper'
require 'spec_helper'

RSpec.describe Judge, type: :model do
  let(:judge) { Judge.new(first_name: "first", last_name: "last") }
  let(:judge_without_first) { Judge.new(first_name: nil, last_name: "last") }
  let(:judge_without_last) { Judge.new(first_name: "first", last_name: nil) }

  describe "judge model validations" do
    it "person is valid with all required fields" do
      expect(judge.first_name).to eq("first")
      expect(judge.last_name).to eq("last")
    end

    it "judge is not valid if first name is missing" do
      expect(judge_without_first.save).to eq(false)
    end

    it "judge is not valid if last name is missing" do
      expect(judge_without_last.save).to eq(false)
    end
  end
end
