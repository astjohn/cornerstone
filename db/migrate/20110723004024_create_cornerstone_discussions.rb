class CreateCornerstoneDiscussions < ActiveRecord::Migration
  def change
    create_table :cornerstone_discussions do |t|
      t.string :name
      t.string :email
      t.integer :user_id
      t.string :category
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end

