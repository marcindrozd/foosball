require 'spec_helper'

describe ChallengesController do
  describe "POST create" do
    context "signed in user" do
      let(:alice) { create(:player) }
      let(:bob) { create(:player) }

      before do
        PlayerMailer.deliveries.clear
        sign_in alice
        post :create, player_id: bob.id, message: "I am challenging you!"
      end

      it "sets sender to currently logged user" do
        expect(assigns(:sender)).to eq(alice)
      end

      it "sets recipient to currently visited profile" do
        expect(assigns(:recipient)).to eq(bob)
      end

      it "sets the message to information entered by the sender" do
        expect(assigns(:message)).to eq("I am challenging you!")
      end

      it "sends email to recipient" do
        expect(PlayerMailer.deliveries.count).to eq(1)
      end

      it "displays success message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "with not signed in user" do
      before do
        PlayerMailer.deliveries.clear
        alice = create(:player)
        post :create, player_id: alice.id
      end

      it "redirects to user sign in page" do
        expect(response).to redirect_to new_player_session_path
      end

      it "does not send an email" do
        expect(PlayerMailer.deliveries.count).to eq(0)
      end
    end
  end
end
