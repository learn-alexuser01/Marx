class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
    respond_to do |format|
      format.json {render json: @page}
    end
  end

  def create
    Page.new({owner: current_user})
    respond_to do |format|
      format.json {render json: @page}
    end
  end

  # params should be automatically parsed from JSON content, except :id
  # make sure MIME type is correct
  def update
    @page = Page.find(params[:id])
    @page.partial_update(params[:updates])
    respond_to do |format|
      format.json {render json: @page}
    end
  end

  def delete
    @page = Page.find(params[:id])
    @page.destroy!
  end
end
