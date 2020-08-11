class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'
  attributes :name, :complited
end