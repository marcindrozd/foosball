class MatchesController < ApplicationController
  before_action :authenticate_player!

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      flash[:notice] = "Match successfully added!"
      redirect_to match_path(@match)
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def index
    @matches = Match.where('player1_id = ? OR player2_id = ?', params[:player_id], params[:player_id])
  end

  private

  def match_params
    params.require(:match).permit(:player1_id, :player2_id, :score_player1, :score_player2)
  end
end
