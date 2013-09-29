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
    title: "Test Page",
    privacy: "public",
    owner: user1
  })
  tile1 = Tile.create!({
    title: "http://www.flickr.com/photos/66294045@N05/9969686144/",
    caption: "Ducks!",
    col: 1,
    row: 1,
    sizex: 2,
    sizey: 1,
    page: page1
  })
  tile2 = Tile.create!({
    title: "http://www.youtube.com/watch?v=Z9uUzryUWnA",
    caption: "OPRAHMONEY",
    col: 3,
    row: 1,
    sizex: 2,
    sizey: 2,
    page: page1
  })
  tile3 = Tile.create!({
    title: "CoolBeans",
    caption: "JellyBeans",
    col: 5,
    row: 1,
    sizex: 1,
    sizey: 2,
    page: page1
  })
  tile4 = Tile.create!({
    title: "http://internetolympiad.org",
    caption: "NIMO",
    col: 1,
    row: 2,
    sizex: 1,
    sizey: 1,
    page: page1
  })
end
