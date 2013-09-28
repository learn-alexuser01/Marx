class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :type
      t.string :title
      t.text :caption
      t.integer :col
      t.integer :row
      t.integer :size_x
      t.integer :size_y
      t.references :page, index: true

      t.timestamps
    end
  end
end
