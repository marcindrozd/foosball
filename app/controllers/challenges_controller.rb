class ChallengesController < ApplicationController
  before_action :authenticate_player!

  def create
    @recipient = Player.find(params[:player_id])
    @sender = current_player
    @message = params[:message]
    PlayerMailer.send_challenge(@sender, @recipient, @message).deliver
    flash[:notice] = "Challenge has been sent!"
    redirect_to @recipient
  end
end
