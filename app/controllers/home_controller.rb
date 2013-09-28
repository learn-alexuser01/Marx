class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    require 'flickraw'
    FlickRaw.api_key="18ec419d7ff691b6b202b8012b63ed41"
    FlickRaw.shared_secret="5f06991ff3d25cd2"
    @photos = flickr.interestingness.getList( :per_page => 1, :page => 1 )
  end
end
