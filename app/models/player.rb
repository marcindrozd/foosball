class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :host_matches, class_name: 'Match', foreign_key: 'player1_id'
  has_many :guest_matches, class_name: 'Match', foreign_key: 'player2_id'

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :first_name, :last_name
end
