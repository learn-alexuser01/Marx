class PagesController < ApplicationController
  before_filter :authenticate_user!

  def show
    respond_to do |format|
      format.json {
        @page = Page.find(params[:id])
        @rel_photo = flickr.photos.search(:text => "test", :per_page =>'10', :page => 1, :sort => 'relevance', :safe_search => '1')
        render partial: 'pages/page.json'

      }
      format.html {
        @photos = flickr.interestingness.getList( :per_page => 10, :page => 1 )
        @pages = Page.where({owner: current_user}).all
        render 'home/index'
      }
    end
  end

  def create
    @page = Page.create!({owner: current_user, title: 'Untitled'})
    respond_to do |format|
      format.json {
        render partial: 'pages/page.json'
      }
    end
  end

  # params should be automatically parsed from JSON content, except :id
  # make sure MIME type is correct
  def update
    @page = Page.find(params[:id])
    if current_user.id != @page.owner_id
      not_found
    end
    @page.partial_update(params[:updates])
    respond_to do |format|
      format.json {
        render partial: 'pages/page.json'
      }
    end
  end

  def delete
    @page = Page.find(params[:id])
    if current_user.id != @page.owner_id
      not_found
    end
    @page.destroy!
  end
end
