class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
end
