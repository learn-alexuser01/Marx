class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'flickraw'
    FlickRaw.api_key="18ec419d7ff691b6b202b8012b63ed41"
    FlickRaw.shared_secret="5f06991ff3d25cd2"
    @interesting_photos = flickr.interestingness.getList( :per_page => 1, :page => 1 )
end
