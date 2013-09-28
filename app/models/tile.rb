class Tile < ActiveRecord::Base
  belongs_to :page, inverse_of: :tiles
end
