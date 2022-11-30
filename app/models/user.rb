class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :weeklyprogresss, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :challenges, through: :participations
  has_one_attached :photo


  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :bio, presence: true
end
