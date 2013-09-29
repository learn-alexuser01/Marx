class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
    respond_to do |format|
      format.json {
        render partial: 'pages/page.json'
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
    @page.partial_update(params[:updates])
    respond_to do |format|
      format.json {
        render partial: 'pages/page.json'
      }
    end
  end

  def delete
    @page = Page.find(params[:id])
    @page.destroy!
  end
end
