class User < ApplicationRecord
  has_secure_password
  has_many :projects
  has_many :tasks
  has_many :comments
  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
  validates :password, confirmation: true, length: { is: 8 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end