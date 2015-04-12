class Match < ActiveRecord::Base
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'

  validates_presence_of :player1_id, :player2_id, :score_player1, :score_player2, :match_date
  validates_numericality_of :score_player1, :score_player2, { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validate :scores_cannot_be_the_same

  def scores_cannot_be_the_same
    if score_player1 == score_player2
      errors.add(:score_player1, "can't be the same as score for player 2")
    end
  end

  def self.matches_between_players(player1, player2)
    if self.where("player1_id IN (?) AND player2_id IN (?)", [player1, player2], [player1, player2]).count > 0
      self.where("player1_id IN (?) AND player2_id IN (?)", [player1, player2], [player1, player2])
    else
      []
    end
  end
end
