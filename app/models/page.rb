class Page < ActiveRecord::Base
  belongs_to :owner, class_name: "User", inverse_of: :pages
  has_many :tiles, inverse_of: :page
end
