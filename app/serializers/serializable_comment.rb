class SerializableComment < JSONAPI::Serializable::Resource
  type 'comments'
  attributes :content, :project_id, :task_id, :user_id
end
