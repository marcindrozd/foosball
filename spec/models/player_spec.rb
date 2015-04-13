require 'spec_helper'

describe Player do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many(:host_matches).class_name('Match').with_foreign_key(:player1_id) }
  it { should have_many(:guest_matches).class_name('Match').with_foreign_key(:player2_id) }

  describe "#full_name" do
    it "returns full name of the player" do
      alice = create(:player, first_name: "Alice", last_name: "Angel")
      expect(alice.full_name).to eq("Alice Angel")
    end
  end

  describe "#add_match_played" do
    it "increases the number of matches played by 1" do
      alice = create(:player, matches_played: 0)
      alice.add_match_played
      expect(alice.matches_played).to eq(1)
    end
  end

  describe "#add_win" do
    it "increases the number of wins by 1" do
      alice = create(:player, number_of_wins: 0)
      alice.add_win
      expect(alice.number_of_wins).to eq(1)
    end
  end

  describe "#add_loss" do
    it "increases the number of losses by 1" do
      alice = create(:player, number_of_losses: 0)
      alice.add_loss
      expect(alice.number_of_losses).to eq(1)
    end
  end

  describe "#update_current_streak" do
    it "updates current streak by 1" do
      alice = create(:player, current_streak: 2)
      alice.update_current_streak
      expect(alice.current_streak).to eq(3)
    end
  end

  describe "#reset_current_streak" do
    it "resets current streak to 0" do
      alice = create(:player, current_streak: 2)
      alice.reset_current_streak
      expect(alice.current_streak).to eq(0)
    end
  end

  describe "#update_total_goals_scored" do
    it "updates the number of total goals scored" do
      alice = create(:player, total_goals_scored: 32)
      alice.update_total_goals_scored(5)
      expect(alice.total_goals_scored).to eq(37)
    end
  end

  describe "#update_total_goals_lost" do
    it "updates the number of total goals lost" do
      alice = create(:player, total_goals_lost: 32)
      alice.update_total_goals_lost(5)
      expect(alice.total_goals_lost).to eq(37)
    end
  end

  describe "#update_points" do
    it "updates number of total points" do
      alice = create(:player, points: 40)
      alice.update_points
      expect(alice.points).to eq(50)
    end
  end

  describe "#update_winning_player_stats" do
    it "updates appropriate statistics for winning player" do
      alice = create(:player, matches_played: 1, number_of_wins: 1, number_of_losses: 0, current_streak: 5, longest_streak: 5, total_goals_scored: 10, total_goals_lost: 5, points: 10)
      alice.update_winning_player_stats(10, 7)
      expect(alice.reload.matches_played).to eq(2)
      expect(alice.reload.number_of_wins).to eq(2)
      expect(alice.reload.number_of_losses).to eq(0)
      expect(alice.reload.current_streak).to eq(6)
      expect(alice.reload.longest_streak).to eq(6)
      expect(alice.reload.total_goals_scored).to eq(20)
      expect(alice.reload.total_goals_lost).to eq(12)
      expect(alice.reload.points).to eq(20)
    end

    it "updates the longest streak if current streak becomes longer than previous longest streak" do
      alice = create(:player, longest_streak: 5, current_streak: 5)
      alice.update_current_streak
      alice.update_winning_player_stats(10, 7)
      expect(alice.reload.longest_streak).to eq(6)
    end

    it "does not update the longest streak when current streak is shorter than previous longest streak" do
      alice = create(:player, longest_streak: 5, current_streak: 3)
      alice.update_winning_player_stats(10, 7)
      expect(alice.reload.longest_streak).to eq(5)
    end

    it "does not update the longest streak when current streak is equal to previous longest streak" do
      alice = create(:player, longest_streak: 5, current_streak: 4)
      alice.update_winning_player_stats(10, 7)
      expect(alice.reload.longest_streak).to eq(5)
    end
  end

  describe "#update_losing_player_stats" do
    it "updates appropriate statistics for losing player" do
      alice = create(:player, matches_played: 1, number_of_wins: 1, number_of_losses: 0, current_streak: 5, longest_streak: 5, total_goals_scored: 10, total_goals_lost: 5, points: 10)
      alice.update_losing_player_stats(7, 10)
      expect(alice.reload.matches_played).to eq(2)
      expect(alice.reload.number_of_wins).to eq(1)
      expect(alice.reload.number_of_losses).to eq(1)
      expect(alice.reload.current_streak).to eq(0)
      expect(alice.reload.longest_streak).to eq(5)
      expect(alice.reload.total_goals_scored).to eq(17)
      expect(alice.reload.total_goals_lost).to eq(15)
      expect(alice.reload.points).to eq(10)
    end
  end

  describe "#win_ratio" do
    it "returns the percentage of won games" do
      alice = create(:player, matches_played: 10, number_of_wins: 5, number_of_losses: 5)
      expect(alice.win_ratio).to eq(50.0)
    end

    it "returns 0 if no matches played" do
      alice = create(:player, matches_played: 0)
      expect(alice.win_ratio).to eq(0)
    end
  end

  describe "#average_goals" do
    it "returns average goals scored per game" do
      alice = create(:player, matches_played: 10, total_goals_scored: 56)
      expect(alice.average_goals).to eq(5.6)
    end
  end

  describe "#find_player_position" do
    it "returns a position of the player based on point" do
      alice = create(:player, points: 10)
      bob = create(:player, points: 30)
      charlie = create(:player, points: 20)
      expect(alice.find_player_position).to eq(3)
      expect(bob.find_player_position).to eq(1)
      expect(charlie.find_player_position).to eq(2)
    end
  end
end
