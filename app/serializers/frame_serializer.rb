class FrameSerializer < ActiveModel::Serializer
  attributes :id, :turn1, :turn2, :turn3, :category, :score
end
