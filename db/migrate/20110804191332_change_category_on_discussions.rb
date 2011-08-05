class ChangeCategoryOnDiscussions < ActiveRecord::Migration
  def up
    remove_column :cornerstone_discussions, :category
    add_column :cornerstone_discussions, :category_id, :integer
  end

  def down
    add_column :cornerstone_discussions, :category, :string
    remove_column :cornerstone_discussions, :category_id
  end
end

