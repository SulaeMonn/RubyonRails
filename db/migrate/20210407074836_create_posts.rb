class CreatePosts < ActiveRecord::Migration[6.1]
  def up
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false
      t.integer :create_user_id, null: false
      t.integer :updated_user_id, null: false
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
