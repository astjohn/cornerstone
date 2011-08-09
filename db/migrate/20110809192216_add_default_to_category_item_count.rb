class AddDefaultToCategoryItemCount < ActiveRecord::Migration
  def up
    change_column :cornerstone_categories, :item_count, :integer, :default => 0
  end

  def down
    change_column :cornerstone_categories, :item_count, :integer
  end
end

