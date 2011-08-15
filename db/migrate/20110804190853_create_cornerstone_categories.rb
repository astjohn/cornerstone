class CreateCornerstoneCategories < ActiveRecord::Migration
  def change
    create_table :cornerstone_categories do |t|
      t.string :name
      t.string :category_type
      t.text :description
      t.integer :item_count, :default => 0
      t.string :latest_discussion_author
      t.datetime :latest_discussion_date

      t.timestamps
    end
  end
end

