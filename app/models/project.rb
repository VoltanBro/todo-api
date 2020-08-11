# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :comments
  validates :name, presence: true, uniqueness: { message: 'The project with such name does already exist.' },
                   length: { in: 3..50 }
end
