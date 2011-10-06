class CreateCornerstoneArticles < ActiveRecord::Migration
  def change
    create_table :cornerstone_articles do |t|
      t.string :title
      t.text :body
      t.integer :category_id

      t.timestamps
    end
  end
end

