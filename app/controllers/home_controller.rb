class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @photos = flickr.interestingness.getList( :per_page => 10, :page => 1 )
    @pages = Page.where({owner: current_user}).all
  end
end
