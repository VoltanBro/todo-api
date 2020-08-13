# frozen_string_literal: true

class SerializableProject < JSONAPI::Serializable::Resource
  type 'projects'
  attributes :name, :user_id
end
