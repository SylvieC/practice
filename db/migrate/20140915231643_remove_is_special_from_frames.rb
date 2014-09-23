class RemoveIsSpecialFromFrames < ActiveRecord::Migration
  def change
    remove_column :frames, :is_special, :boolean
  end
end
