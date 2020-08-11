# frozen_string_literal: true

class SerializableProject < JSONAPI::Serializable::Resource
  type 'projects'
  attributes :name
  # belongs_to :user
  # has_many   :tasks
  # has_many   :comments
end
