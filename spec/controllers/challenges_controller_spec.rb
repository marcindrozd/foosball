require 'spec_helper'

describe ChallengesController do
  describe "POST create" do
    context "signed in user" do
      it "sets sender to currently logged user" do
        alice = create(:player)
        bob = create(:player)
        sign_in alice
        post :create, player_id: bob.id
        expect(assigns(:sender)).to eq(alice)
      end

      it "sets recipient to currently visited profile" do
        alice = create(:player)
        bob = create(:player)
        sign_in alice
        post :create, player_id: bob.id
        expect(assigns(:recipient)).to eq(bob)
      end

      it "sets the message to information entered by the sender" do
        alice = create(:player)
        bob = create(:player)
        sign_in alice
        post :create, player_id: bob.id, message: "I am challenging you!"
        expect(assigns(:message)).to eq("I am challenging you!")
      end

      it "send email to recipient"
      it "displays success message" do
        alice = create(:player)
        bob = create(:player)
        sign_in alice
        post :create, player_id: bob.id
        expect(flash[:notice]).to be_present
      end
    end

    context "with not signed in user" do
      it "redirects to user sign in page" do
        alice = create(:player)
        post :create, player_id: alice.id
        expect(response).to redirect_to new_player_session_path
      end

      it "does not send an email"
    end
  end
end
