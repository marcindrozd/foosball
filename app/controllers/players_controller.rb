class PlayersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show
    @player = Player.find(params[:id])
    @recent_matches = Match.recent_matches(@player)
  end

  def index
    @players = Player.order(sort_column + ' ' + sort_direction)
  end

  private

  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : "points"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
