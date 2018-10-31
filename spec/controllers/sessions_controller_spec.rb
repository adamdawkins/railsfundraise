require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET /sessions/new' do
    it 'returns the new session template' do
      get :new

      assert_template 'sessions/new'
    end
  end

  describe 'POST create' do
    let (:user) { User.create(email: 'some@email.com', password: 'secret') }

    describe "with valid params" do
      let (:campaign) { FactoryBot.create(:campaign) }

      before :each do
        allow(User).to receive(:find_by).with(email: "some@email.com").and_return(user)
        allow(user).to receive(:authenticate).and_return(true)
        allow(user).to receive_message_chain(:campaigns, :first).and_return(campaign)
      end
      it "should authenticate user and redirect" do
        post :create, params: { email: "some@email.com", password: "secret" }

        expect(user).to have_received(:authenticate).with("secret")
        expect(session[:user_id]).to eql user.id
        expect(flash[:notice]).to_not be_nil
      end

      it "should redirect to user's campaign" do
        post :create, params: { email: "some@email.com", password: "secret" }
        expect(response).to redirect_to(campaign_path(campaign))
      end
    end

    describe "with invalid params" do
      it "should not authenticate if user not exists" do
        allow(User).to receive(:find_by).and_return(nil)

        post :create, params: { email: "some@email.com", password: "secret" }
        expect(assigns(:user)).to be_nil
      end

      it "should not authenticate if given password invalid" do
        allow(User).to receive(:find_by).with(email: "some@email.com").and_return(user)
        allow(user).to receive(:authenticate).and_return(false)

        post :create, params: { email: "some@email.com", password: "not_sceret" }

        expect(session[:user_id]).to be_nil
      end

      after(:each) do
        expect(flash[:alert]).to_not be_nil
        expect(response).to render_template(:new)
      end
    end
  end
end
