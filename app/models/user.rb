class User < ActiveRecord::Base
  devise :omniauthable, :rememberable, :database_authenticatable, :registerable, :omniauth_providers => [:facebook]
end
