require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:donations) }
  it { is_expected.to validate_presence_of(:title) }

end
