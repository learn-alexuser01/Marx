class Tile < ActiveRecord::Base
  belongs_to :page, inverse_of: :tiles

  def parse_flickr_url
    re = /flickr\.com\/photos\/[^\/]+\/(?<img>[0-9]+)/
    m = re.match(title)
    return nil if m.nil?
    m[1]
  end

  def parse_youtube_url
    re = /youtube\.com\/watch\?v=(\w{11})/
    m = re.match(title)
    return nil if m.nil?
    m[1]
  end

  def match_http_url
    return URI::regexp(['http']).match(title) != nil
  end
end
