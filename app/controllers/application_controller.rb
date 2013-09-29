class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def interesting_photo
    return flickr.interestingness.getList( :per_page => 1, :page => 1 )
  end

  def not_found
      raise ActionController::RoutingError.new('Not Found')
  end
end
