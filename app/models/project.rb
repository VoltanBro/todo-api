class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :comments
  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
end
