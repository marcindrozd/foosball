class Match < ActiveRecord::Base
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'

  validates_presence_of :player1_id, :player2_id, :score_player1, :score_player2
end
