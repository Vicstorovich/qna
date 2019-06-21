require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user, password: "1234567" }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email)}

  describe "#valid_password?" do
    it "should return true" do
      expect(subject.valid_password?("1234567")).to eq true
    end

    it "should return true" do
      expect(subject.valid_password?("7234567")).to eq false
    end
  end
end
