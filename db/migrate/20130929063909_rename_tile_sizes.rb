class RenameTileSizes < ActiveRecord::Migration
  def change
    rename_column :tiles, :size_x, :sizex
    rename_column :tiles, :size_y, :sizey
  end
end
