class ChangeTileTypeColumn < ActiveRecord::Migration
  def change
    rename_column :tiles, :type, :contenttype
  end
end
