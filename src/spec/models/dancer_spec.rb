require 'rails_helper'
require 'spec_helper'

RSpec.describe Person, type: :model do
  let(:person) { Person.new(first_name: "first", last_name: "last", wsdc_id: 1234) }
  let(:person_without_first) { Person.new(first_name: nil, last_name: "last") }
  let(:person_without_last) { Person.new(first_name: "first", last_name: nil) }


  describe "description" do
    it "person is valid with all required fields" do
      expect(person.first_name).to eq("first")
      expect(person.last_name).to eq("last")
      expect(person.wsdc_id).to eq(1234)
    end

    it "person is not valid if first name is missing" do
      expect(person_without_first.save).to eq(false)
    end

    it "person is not valid if last name is missing" do
      expect(person_without_last.save).to eq(false)
    end

    it "WSDC ID must be a number" do
      wsdc = Person.new(first_name: "first", last_name: "last", wsdc_id: "1234")
      expect(wsdc.save).to eq(false)
    end
  end
end
