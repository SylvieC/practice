class Game < ActiveRecord::Base
  belongs_to :user
  has_many :frames
  has_many :comments
  accepts_nested_attributes_for :frames
  accepts_nested_attributes_for :comments
end
