require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "redirects to /run-for-freedom" do
      get :index

      expect(response).to redirect_to run_for_freedom_path
    end
  end
end
