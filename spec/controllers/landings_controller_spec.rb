require 'rails_helper'

RSpec.describe LandingsController, type: :controller do
  describe "GET /teachers" do
    it "renders the teachers template" do
      get :teachers

      assert_template "landings/teachers"
    end
  end
end
