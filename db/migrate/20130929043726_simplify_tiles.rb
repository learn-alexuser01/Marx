class SimplifyTiles < ActiveRecord::Migration
  def change
    remove_column :tiles, :contenttype
  end
end
