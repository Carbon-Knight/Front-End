class User < ApplicationRecord
  validates :name, presence: true
  validates :email, :uid, :token, uniqueness: true, presence: true
end
