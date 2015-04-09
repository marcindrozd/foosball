require 'spec_helper'

describe MatchesController do
  describe "GET new" do
    context "with user not signed in" do
      it "redirects to sign_in path" do
        get :new
        expect(response).to redirect_to new_player_session_path
      end
    end

    context "with signed in user" do
      it "creates Match object" do
        alice = create(:player)
        sign_in alice
        get :new
        expect(assigns(:match)).to be_instance_of(Match)
      end
    end
  end

  describe "POST create" do
    context "with user not signed in" do
      it "redirects to sign in path" do
        post :create, match: { player1: "player1", player2: "player2", score_player1: "10", score_player2: "5" }
        expect(response).to redirect_to new_player_session_path
      end

      it "does not create a new match" do
        post :create, match: { player1: "player1", player2: "player2", score_player1: "10", score_player2: "5" }
        expect(Match.count).to eq(0)
      end
    end
  end
end
