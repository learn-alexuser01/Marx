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
    begin
      sizes = flickr.photos.getSizes(photo_id: id)
      url = sizes.to_a.last["source"]
    rescue
      url = nil
    end
    render 'tiles/flickr.html', tile: tile, imgurl: url
  end

  def tile_youtube_render(tile, id)
    render 'tiles/youtube.html', tile: tile, id: id
  end

  def tile_url_render(tile)
    Net::HTTP.get(URI(tile.title)) =~ /<title>(.*?)<\/title>/
    render 'tiles/url.html', tile: tile, page_title: $1
  end

  def tile_plain_render(tile)
    render 'tiles/plain.html', tile: tile
  end
end
