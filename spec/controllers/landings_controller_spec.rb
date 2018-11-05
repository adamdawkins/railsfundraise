require 'rails_helper'

RSpec.describe LandingsController, type: :controller do
  describe "GET /run-for-freedom" do
    it "renders the run_for_freedom template" do
      get :run_for_freedom

      assert_template "landings/run_for_freedom"
    end
  end

  describe "GET /teachers" do
    it "renders the teachers template" do
      get :teachers

      assert_template "landings/teachers"
    end
  end
end
