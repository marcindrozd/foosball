# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

alice = Player.create(first_name: "Alice", last_name: "Arbelo", email: "alice@example.com",
                      password: "password", password_confirmation: "password",
                      avatar: open("public/tmp/alice.png"),
                      matches_played: 6, number_of_wins: 4, number_of_losses: 2,
                      current_streak: 0, longest_streak: 2,
                      total_goals_scored: 55, total_goals_lost: 45, points: 40)

bob = Player.create(first_name: "Bob", last_name: "Brothers", email: "bob@example.com",
                    password: "password", password_confirmation: "password",
                    avatar: open("public/tmp/bob.png"),
                    matches_played: 5, number_of_wins: 3, number_of_losses: 2,
                    current_streak: 0, longest_streak: 2,
                    total_goals_scored: 44, total_goals_lost: 36, points: 30)

charlie = Player.create(first_name: "Charlie", last_name: "Chaps", email: "charlie@example.com",
                        password: "password", password_confirmation: "password",
                        avatar: open("public/tmp/charlie.png"),
                        matches_played: 4, number_of_wins: 1, number_of_losses: 3,
                        current_streak: 0, longest_streak: 1,
                        total_goals_scored: 29, total_goals_lost: 38, points: 10)

donald = Player.create(first_name: "Donald", last_name: "Duckling", email: "donald@example.com",
                        password: "password", password_confirmation: "password",
                        avatar: open("public/tmp/donald.png"),
                        matches_played: 5, number_of_wins: 2, number_of_losses: 3,
                        current_streak: 1, longest_streak: 1,
                        total_goals_scored: 36, total_goals_lost: 45, points: 20)

Match.create(player1_id: alice.id, player2_id: charlie.id,
            score_player1: 10, score_player2: 7, match_date: Date.new(2015,2,26))

Match.create(player1_id: charlie.id, player2_id: bob.id,
            score_player1: 5, score_player2: 10, match_date: Date.new(2015,2,27))

Match.create(player1_id: donald.id, player2_id: alice.id,
            score_player1: 3, score_player2: 10, match_date: Date.new(2015,2,27))

Match.create(player1_id: charlie.id, player2_id: alice.id,
            score_player1: 10, score_player2: 8, match_date: Date.new(2015,3,1))

Match.create(player1_id: alice.id, player2_id: bob.id,
            score_player1: 10, score_player2: 6, match_date: Date.new(2015,3,2))

Match.create(player1_id: donald.id, player2_id: charlie.id,
            score_player1: 10, score_player2: 7, match_date: Date.new(2015,3,2))

Match.create(player1_id: donald.id, player2_id: bob.id,
            score_player1: 4, score_player2: 10, match_date: Date.new(2015,3,5))

Match.create(player1_id: donald.id, player2_id: alice.id,
            score_player1: 9, score_player2: 10, match_date: Date.new(2015,3,8))

Match.create(player1_id: bob.id, player2_id: alice.id,
            score_player1: 10, score_player2: 7, match_date: Date.new(2015,3,11))

Match.create(player1_id: bob.id, player2_id: donald.id,
            score_player1: 8, score_player2: 10, match_date: Date.new(2015,3,13))
