# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :project
  belongs_to :user
  has_one_attached :image
  validates :image, content_type: %i[png jpg jpeg],
                    size: { less_than: 10.megabytes, message: 'An uploaded file is too large. The size shouldn’t exceed 10 MB.' }
  validates :content, presence: true, length: { minimum: 10, maximum: 256 }
end
