require 'rails_helper'

RSpec.describe User, type: :model do
 it { is_expected.to have_many(:campaigns) }

 describe "first_name" do
   it "returns the name before the first space in full name" do
     user = FactoryBot.build(:user, full_name: 'Jonathan Bowen')
     expect(user.first_name).to eq 'Jonathan'
   end
 end
end
