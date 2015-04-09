class MatchesController < ApplicationController
  before_action :authenticate_player!

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
  end

  private

  def match_params
    params.require(:match).permit(:player1, :player2, :score_player1, :score_player2)
  end
end
