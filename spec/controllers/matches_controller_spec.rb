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
        post :create, match: { player1_id: "1", player2_id: "2", score_player1: "10", score_player2: "5" }
        expect(response).to redirect_to new_player_session_path
      end

      it "does not create a new match" do
        post :create, match: { player1_id: "1", player2_id: "2", score_player1: "10", score_player2: "5" }
        expect(Match.count).to eq(0)
      end
    end

    context "with signed in user and valid data" do
      let(:alice) { create(:player) }

      before do
        sign_in alice
        post :create, match: { player1_id: alice.id, player2_id: "2", score_player1: "10", score_player2: "5", match_date: Date.new() }
      end

      it "redirects to show match page" do
        expect(response).to redirect_to match_path(Match.first)
      end

      it "creates a new match" do
        expect(Match.count).to eq(1)
      end

      it "displays success message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "with signed in user and invalid data" do
      it "renders new template" do
        alice = create(:player)
        sign_in alice
        post :create, match: { player1_id: alice.id, player2_id: "2", score_player1: "abc", score_player2: "5" }
        expect(response).to render_template :new
      end

      it "displays error message" do
        alice = create(:player)
        sign_in alice
        post :create, match: { player1_id: alice.id, player2_id: "2", score_player1: "abc", score_player2: "5" }
        expect(flash[:danger]).to be_present
      end

      it "does not create a new match" do
        alice = create(:player)
        sign_in alice
        post :create, match: { player1_id: alice.id, player2_id: "2", score_player1: "abc", score_player2: "5" }
        expect(Match.count).to eq(0)
      end
    end
  end
end
