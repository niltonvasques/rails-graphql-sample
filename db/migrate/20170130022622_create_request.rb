class CreateRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title, index: true
      t.text :content, limit: nil
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
