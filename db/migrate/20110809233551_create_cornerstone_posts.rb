class CreateCornerstonePosts < ActiveRecord::Migration
  def change
    create_table :cornerstone_posts do |t|
      t.integer :discussion_id
      t.integer :user_id
      t.string :name
      t.string :email
      t.text :body
      t.timestamps
    end
  end
end

