require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:campaigns) }
  it { is_expected.to accept_nested_attributes_for(:campaigns) }

  describe "first_name" do
    it "returns the name before the first space in full name" do
      user = FactoryBot.build(:user, full_name: 'Jonathan Bowen')
      expect(user.first_name).to eq 'Jonathan'
    end
  end

  describe "last_name" do
    it "returns the name before the last space in full name" do
      user = FactoryBot.build(:user, full_name: 'Jonathan Bowen')
      expect(user.last_name).to eq 'Bowen'
    end
  end
end
