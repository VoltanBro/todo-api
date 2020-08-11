# frozen_string_literal: true

class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'
  attributes :name, :complited
  # belongs_to :project
  # belongs_to :user
end
