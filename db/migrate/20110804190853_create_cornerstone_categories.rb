class CreateCornerstoneCategories < ActiveRecord::Migration
  def change
    create_table :cornerstone_categories do |t|
      t.string :name
      t.string :category_type
      t.integer :item_count
      t.timestamps
    end
  end
end

