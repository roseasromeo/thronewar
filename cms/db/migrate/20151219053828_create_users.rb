class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :name, unique: true, null: false
      t.string :password_digest, null: false

      t.integer :user_type, null: false, default: 2

      t.timestamps null: false
    end
  end
end
