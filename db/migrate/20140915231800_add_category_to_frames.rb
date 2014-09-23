class AddCategoryToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :category, :string
  end
end
