class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def interesting_photo
    return flickr.interestingness.getList( :per_page => 1, :page => 1 )
  end

  def parse_flickr_url(url)
    re = /flickr\.com\/photos\/[^\/]+\/(?<img>[0-9]+)/i
    m = re.match(url)
    return nil if m.nil?
    m[1]
  end

  def parse_youtube_url(url)
    re = /youtube\.com\/watch\?v=(\w{11})/i
    m = re.match(url)
    return nil if m.nil?
    m[1]
  end

  def not_found
      raise ActionController::RoutingError.new('Not Found')
  end
end
