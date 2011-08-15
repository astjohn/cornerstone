class CreateCornerstoneDiscussions < ActiveRecord::Migration
  def change
    create_table :cornerstone_discussions do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :subject
      t.string :status, :default => Cornerstone::Config.discussion_statuses.first
      t.boolean :privte, :default => 0
      t.integer :reply_count, :default => 0
      t.string :latest_post_author
      t.datetime :latest_post_date

      t.timestamps
    end
  end
end

