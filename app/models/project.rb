class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
end
