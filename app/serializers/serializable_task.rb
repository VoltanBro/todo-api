# frozen_string_literal: true

class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'
  attributes :name, :complited, :project_id, :user_id, :deadline, :created_at
end
