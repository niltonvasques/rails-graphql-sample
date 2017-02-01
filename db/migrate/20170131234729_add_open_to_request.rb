class AddOpenToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :open, :boolean, default: true
  end
end
