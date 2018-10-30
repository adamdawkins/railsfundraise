require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns an ok response" do
      get :new
      expect(response.status).to be 200
      assert_template 'users/new'
    end

    it "returns a new user for @user" do 
      get :new
      expect(assigns(:user).class.name).to eq 'User'
    end
  end

  describe "POST #create" do
    let (:params) { { full_name: 'Adam Dawkins', email: 'email@example.com', password: 'password' } }

    it "saves the user" do
      expect do
        post :create, :params => { user: params }
      end.to change(User, 'count').from(0).to(1)
    end

    it "creates a campaign with title `first name's run for freedom'" do
      post :create, :params => { user: params }
      expect(Campaign.first.title).to eq "Adam's Run For Freedom"
    end

    context "when the user is saved successfully" do 
      it "redirects to the campaign page" do
        post :create, :params => { user: params }
        user = assigns(:user)
        expect(response).to redirect_to(campaign_path(user.campaigns.first))
      end
    end

    context "when there is an error" do 
      before do 
        allow_any_instance_of(User).to receive(:save).and_return false
      end
      it "re-renders the new page" do
        post :create, :params => { user: params }
        assert_template 'users/new'
      end
    end
  end
end
