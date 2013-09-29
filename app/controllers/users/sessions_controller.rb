class Users::SessionsController < Devise::SessionsController
  def new
    @photos = interesting_photo
    super
  end
end
