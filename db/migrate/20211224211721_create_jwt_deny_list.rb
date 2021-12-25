class CreateJwtDenyList < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_denylists do |t|
      t.string "jti", null: false
      t.datetime "exp", null: false
      t.index ["jti"], name: "index_jwt_denylists_on_jti"
    end
  end
end
