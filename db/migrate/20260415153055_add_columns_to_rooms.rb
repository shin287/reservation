class AddColumnsToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :introducution, :text
    add_column :rooms, :price, :integer
    add_column :rooms, :address, :string
    add_reference :rooms, :user, null: false, foreign_key: true
  end
end
