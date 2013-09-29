class Page < ActiveRecord::Base
  belongs_to :owner, class_name: "User", inverse_of: :pages
  has_many :tiles, inverse_of: :page, dependent: :destroy

  def partial_update(update)
    page_update = update[:page]
    page_update.delete(:id)
    self.update(page_update)

    tile_update = update[:tiles]

    new_tiles = tile_update[:new]
    updated_tiles = tile_update[:updated]
    deleted_tiles = tile_update[:deleted]

    new_tiles.each do |tile|
      tile.delete(:id)
      self.tiles.create!(tile)
    end

    updated_tiles.each do |tile_and_id|
      tile = self.tiles.where({id: tile_and_id[:id]}).first
      if !tile.nil?
        tile_and_id[:tile].delete(:id)
        tile.update!(tile_and_id[:tile])
      end
    end

    deleted_tiles.each do |id|
      tile = self.tiles.where(id).first
      if !tile.nil?
        tile.destroy!
      end
    end
  end
end
