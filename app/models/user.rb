class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_one_attached :avatar
end
