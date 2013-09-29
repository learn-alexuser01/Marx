class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @photos = interesting_photo
    super
  end
end
