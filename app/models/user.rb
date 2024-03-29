class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :weekly_progresses, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :challenges, through: :participations
  has_many :orders, through: :participations
  has_one_attached :photo
  # has_many :messages

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :bio, presence: true
  validates :photo, presence: true
end
