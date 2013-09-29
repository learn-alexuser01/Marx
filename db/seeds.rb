# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Rails.env.development?
  user1 = User.create!({
    name: "Test User",
    email: "user@example.com",
    password: "password",
    password_confirmation: "password"
  })
  page1 = Page.create!({
    title: "Hire me!",
    privacy: "public",
    owner: user1
  })
  tile1 = Tile.create!({
    title: "http://www.flickr.com/photos/93566551@N07/10003059995/",
    caption: "Shrav Mehta",
    col: 1,
    row: 1,
    sizex: 1,
    sizey: 1,
    page: page1
  })
  tile2 = Tile.create!({
    title: "http://www.flickr.com/photos/93566551@N07/10003059394/",
    caption: "Douglas Chen",
    col: 2,
    row: 1,
    sizex: 1,
    sizey: 1,
    page: page1
  })
  tile3 = Tile.create!({
    title: "http://www.flickr.com/photos/93566551@N07/10003057894/",
    caption: "Prem Nair",
    col: 3,
    row: 1,
    sizex: 1,
    sizey: 1,
    page: page1
  })
end
