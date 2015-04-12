FactoryGirl.define do
  factory :match do
    player1_id 1
    player2_id 2
    score_player1 10
    score_player2 6
    match_date Date.new()
  end
end
