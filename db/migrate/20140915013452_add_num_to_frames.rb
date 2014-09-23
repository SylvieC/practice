class AddNumToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :num, :integer
  end
end
