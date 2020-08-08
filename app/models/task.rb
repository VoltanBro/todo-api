class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :comments
  validates :name, presence: true, uniqueness: true, length: { in: 3..256 }
end
