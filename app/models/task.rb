class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, presence: true, uniqueness: true, length: { in: 3..256 }
end
