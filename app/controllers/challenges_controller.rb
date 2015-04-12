class ChallengesController < ApplicationController
  def create
    @player = Player.find(params[:player_id])
    flash[:notice] = "Challenge has been sent!"
    redirect_to @player
  end
end
