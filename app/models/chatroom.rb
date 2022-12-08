class Chatroom < ApplicationRecord
  belongs_to :challenge
  has_many :messages

  validates_uniqueness_of  :name
  scope :public_chatrooms, -> { where(is_private: false) }
end
