class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :author_id
      t.integer :post_id
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
