class FixRoomIntroductionName < ActiveRecord::Migration[7.2]
  def change
    rename_column :rooms, :introducution, :introduction
  end
end
