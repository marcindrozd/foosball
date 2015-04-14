class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :host_matches, class_name: 'Match', foreign_key: 'player1_id'
  has_many :guest_matches, class_name: 'Match', foreign_key: 'player2_id'

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def update_winning_player_stats(goals_scored, goals_lost)
    self.add_match_played
    self.add_win
    self.update_current_streak
    if self.current_streak > self.longest_streak
      self.longest_streak += 1
    end
    self.update_total_goals_scored(goals_scored)
    self.update_total_goals_lost(goals_lost)
    self.update_points
    self.save
  end

  def update_losing_player_stats(goals_scored, goals_lost)
    self.add_match_played
    self.add_loss
    self.reset_current_streak
    self.update_total_goals_scored(goals_scored)
    self.update_total_goals_lost(goals_lost)
    self.save
  end

  def win_ratio
    if self.matches_played == 0
      0
    else
      (self.number_of_wins.to_f / self.matches_played) * 100
    end
  end

  def add_match_played
    self.matches_played += 1
  end

  def add_win
    self.number_of_wins += 1
  end

  def add_loss
    self.number_of_losses += 1
  end

  def update_current_streak
    self.current_streak += 1
  end

  def reset_current_streak
    self.current_streak = 0
  end

  def update_total_goals_scored(goals)
    self.total_goals_scored += goals
  end

  def update_total_goals_lost(goals)
    self.total_goals_lost += goals
  end

  def update_points
    self.points += 10
  end

  def average_goals
    (self.total_goals_scored.to_f / self.matches_played).round(1)
  end

  def find_player_position
    Player.order(points: :desc).index(self) + 1
  end
end
