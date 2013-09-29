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
    contenttype: "image",
    title: "http://www.flickr.com/photos/66294045@N05/9969686144/",
    caption: "Ducks!",
    col: 0,
    row: 0,
    size_x: 2,
    size_y: 1,
    page: page1
  })
  tile2 = Tile.create!({
    contenttype: "video",
    title: "http://www.youtube.com/watch?v=Z9uUzryUWnA",
    caption: "OPRAHMONEY",
    col: 2,
    row: 0,
    size_x: 2,
    size_y: 2,
    page: page1
  })
  tile3 = Tile.create!({
    contenttype: "text",
    title: "CoolBeans",
    caption: "JellyBeans",
    col: 4,
    row: 0,
    size_x: 1,
    size_y: 2,
    page: page1
  })
  tile4 = Tile.create!({
    contenttype: "page",
    title: "http://internetolympiad.org",
    caption: "NIMO",
    col: 0,
    row: 1,
    size_x: 1,
    size_y: 1,
    page: page1
  })
end
