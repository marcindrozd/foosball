class MatchesController < ApplicationController
  before_action :authenticate_player!, only: [:new, :create]

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      player1 = Player.find(params[:match][:player1_id])
      player2 = Player.find(params[:match][:player2_id])
      score_player1 = params[:match][:score_player1].to_i
      score_player2 = params[:match][:score_player2].to_i
      handle_winner_and_loser(player1, player2, score_player1, score_player2)
      flash[:notice] = "Match successfully added!"
      redirect_to match_path(@match)
    else
      flash[:danger] = "Please check below error messages"
      render :new
    end
  end

  def show
    @match = Match.find(params[:id])
    @previous_matches = Match.matches_between_players(@match.player1, @match.player2)
  end

  def index
    @matches = Match.where('player1_id = ? OR player2_id = ?', params[:player_id], params[:player_id])
  end

  private

  def match_params
    params.require(:match).permit(:player1_id, :player2_id, :score_player1, :score_player2, :match_date)
  end

  def handle_winner_and_loser(player1, player2, score_player1, score_player2)
    if score_player1 > score_player2
      player1.update_winning_player_stats(score_player1, score_player2)
      player2.update_losing_player_stats(score_player2, score_player1)
    else
      player1.update_losing_player_stats(score_player1, score_player2)
      player2.update_winning_player_stats(score_player2, score_player1)
    end
  end
end
