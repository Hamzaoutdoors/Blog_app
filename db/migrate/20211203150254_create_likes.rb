class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.bigint :author_id
      t.bigint :post_id

      t.timestamps
    end

    add_foreign_key :likes, :users,  column: :author_id
    add_foreign_key :likes, :posts, column: :post_id

    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
