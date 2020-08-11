# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :project
  belongs_to :user

  validates :content, presence: true, length: { minimum: 10, maximum: 256 }
end
