class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
  end
end
