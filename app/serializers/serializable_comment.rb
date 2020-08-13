class SerializableComment < JSONAPI::Serializable::Resource
  type 'comments'
  attributes :content
  # belongs_to :user
  # has_many   :tasks
  # has_many   :comments
end
