class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.json {render json: @page}
    end
  end

  def create
    Page.new({owner: current_user})

  end

  def update
    @page = Page.find(params[:id])

  end

  def delete
    @page = Page.find(params[:id])
    @page.destroy
  end
end
