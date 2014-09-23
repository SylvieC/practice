class AddIsSpecialToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :is_special, :boolean
  end
end
