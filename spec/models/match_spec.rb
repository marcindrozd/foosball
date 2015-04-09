require 'spec_helper'

describe Match do
  it { should validate_presence_of :player1_id }
  it { should validate_presence_of :player2_id }
  it { should validate_presence_of :score_player1 }
  it { should validate_presence_of :score_player2 }
  it { should belong_to(:player1).class_name('Player') }
  it { should belong_to(:player2).class_name('Player') }
end
