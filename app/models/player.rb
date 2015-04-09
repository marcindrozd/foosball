class Player < ActiveRecord::Base
  has_many :host_matches, class_name: 'Match', foreign_key: 'player1_id'
  has_many :guest_matches, class_name: 'Match', foreign_key: 'player2_id'

  validates_presence_of :first_name, :last_name
end
