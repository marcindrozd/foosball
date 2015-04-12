require 'spec_helper'

describe Match do
  it { should validate_presence_of :player1_id }
  it { should validate_presence_of :player2_id }
  it { should validate_presence_of :score_player1 }
  it { should validate_presence_of :score_player2 }
  it { should validate_presence_of :match_date }
  it { should belong_to(:player1).class_name('Player') }
  it { should belong_to(:player2).class_name('Player') }
  it { should validate_numericality_of(:score_player1).only_integer }
  it { should validate_numericality_of(:score_player2).only_integer }
  it { should_not allow_value(-1).for(:score_player1) }
  it { should_not allow_value(-1).for(:score_player2) }
  it { should allow_value(0).for(:score_player1) }
  it { should allow_value(0).for(:score_player2) }
  it { should_not allow_value(11).for(:score_player1) }
  it { should_not allow_value(11).for(:score_player1) }

  describe ".matches_between_players" do
    it "returns empty array if there are no matches between the two players" do
      alice = create(:player)
      bob = create(:player)
      expect(Match.matches_between_players(alice, bob)).to eq([])
    end

    it "returns a match between the players if there is a match" do
      alice = create(:player)
      bob = create(:player)
      match = create(:match, player1_id: alice.id, player2_id: bob.id)
      expect(Match.matches_between_players(alice, bob)).to eq([match])
    end

    it "returns all matches between two players" do
      alice = create(:player)
      bob = create(:player)
      match1 = create(:match, player1_id: alice.id, player2_id: bob.id)
      match2 = create(:match, player1_id: bob.id, player2_id: alice.id)
      match3 = create(:match, player1_id: alice.id, player2_id: bob.id)
      expect(Match.matches_between_players(alice, bob)).to match_array([match1, match2, match3])
    end

    it "returns only matches between the two players" do
      alice = create(:player)
      bob = create(:player)
      charlie = create(:player)
      match1 = create(:match, player1_id: alice.id, player2_id: bob.id)
      match2 = create(:match, player1_id: bob.id, player2_id: alice.id)
      match3 = create(:match, player1_id: alice.id, player2_id: charlie.id)
      expect(Match.matches_between_players(alice, bob)).to match_array([match1, match2])
    end
  end
end
