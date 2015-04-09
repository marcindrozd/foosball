class AddStatisticsFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :matches_played, :integer, default: 0
    add_column :players, :number_of_wins, :integer, default: 0
    add_column :players, :number_of_losses, :integer, default: 0
    add_column :players, :current_streak, :integer, default: 0
    add_column :players, :longest_streak, :integer, default: 0
    add_column :players, :total_goals_scored, :integer, default: 0
    add_column :players, :total_goals_lost, :integer, default: 0
    add_column :players, :points, :integer, default: 0
  end
end
