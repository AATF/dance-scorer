require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    it "returns default title without extra_title" do
      expect(helper.page_title).to eq("#{Setting.app_name} Dance Scorer")
    end

    it "appends extra_title when provided" do
      expect(helper.page_title("Leaderboard")).to eq("#{Setting.app_name} Dance Scorer - Leaderboard")
    end
  end

  describe "#app_version" do
    it "returns the version string when VERSION file is present" do
      expected_file = [Rails.root.join("VERSION"), Rails.root.join("../VERSION")].find { |p| File.file?(p) }
      expect(helper.app_version).to eq(File.read(expected_file).strip)
    end

    it "returns nil when VERSION file does not exist" do
      allow(File).to receive(:file?).and_return(false)
      expect(helper.app_version).to be_nil
    end

    it "returns nil when VERSION file is empty" do
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:read).and_return("   \n")
      expect(helper.app_version).to be_nil
    end
  end
end

