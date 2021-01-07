class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :uid, uniqueness: true, presence: true
  validates :token, uniqueness: true, presence: true
end
