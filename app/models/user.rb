class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participations, dependent: :destroy
  has_many :weeklyprogresss, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :challenges, through: :participations

end
