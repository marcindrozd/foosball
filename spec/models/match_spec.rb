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
end
