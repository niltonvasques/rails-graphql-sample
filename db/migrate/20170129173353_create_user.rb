class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token
      t.boolean :customer, default: true
      t.boolean :agent, default: false
      t.boolean :admin, default: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
