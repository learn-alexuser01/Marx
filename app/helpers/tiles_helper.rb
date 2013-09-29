module TilesHelper

  def tile_render(tile)
    ti = tile.title
    case
    when (id = tile.parse_flickr_url) != nil
      tile_flickr_render(tile, id)
    when (id = tile.parse_youtube_url) != nil
      tile_youtube_render(tile, id)
    when tile.match_http_url
      tile_url_render(tile)
    else
      tile_plain_render(tile)
    end
  end

  def tile_flickr_render(tile, id)
    # do some api stuff
    url = "asdf"
    render 'tiles/flickr.html', tile: tile, imgurl: url
  end

  def tile_youtube_render(tile, id)
    render 'tiles/youtube.html', tile: tile, id: id
  end

  def tile_url_render(tile)
    # do some summarizing
    render 'tiles/url.html', tile: tile
  end

  def tile_plain_render(tile)
    render 'tiles/plain.html', tile: tile
  end
end
