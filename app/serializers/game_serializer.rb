class GameSerializer < ActiveModel::Serializer
  attributes :id, :is_completed, :is_special
  has_many :frames
  has_many :comments
end
