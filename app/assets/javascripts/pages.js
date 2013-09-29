Page = {}

// callback receives the page content
Page.show = function(id, callback) {
  $.get('/pages/' + id + '.json', null, callback)
}

// callback receives the page content
Page.create = function(callback) {
  $.post('/pages.json', null, callback)
}

// page is a Page object
// newTiles, updatedTiles and deletedTiles are arrays of Tile objects
// id does not need to be set for new tiles.
// callback receives the page content
Page.update = function(id, callback, page, newTiles, updatedTiles, deletedTiles) {

  var n = new Array();
  for(var i = 0; i < newTiles.length; i++) {
    n[i] = newTiles[i]
  }

  var u = new Array();
  for(var i = 0; i < updatedTiles.length; i++) {
    u[i] = {
      id: updatedTiles[i].id,
      tile: updatedTiles[i]
    }
  }

  var d = new Array();
  for(var i = 0; i < deletedTiles.length; i++) {
    d[i] = deletedTiles[i].id
  }

  var updates = {
    page: page,
    tiles: {
      new: n,
      updated: u,
      deleted: d
    }
  }

  $.post('/pages/' + id + '.json', {
    _method: 'PUT',
    updates: updates
  }, callback)
}

// callback receives nothing
Page.delete = function(id, callback) {
  $.post('/pages/' + id + '.json', {
    _method: 'DELETE'
  }, callback)
}

Page.render = function(data) {
  $('.header h1').html(data.title)
  $('.header h2').html(data.owner_name)
  var gridster = $('.gridster ul').gridster().data('gridster')
  var existing = $('.gridster li')
  for(i = 0; i < existing.length; i++) {
    gridster.remove_widget(existing[i]);
  }
  var tiles = data.tiles
  for(i = 0; i < tiles.length; i++) {
    var tile = tiles[i];
    gridster.add_widget('<li class="gs_w">' + tile.rendered_content +
        '</li>', tile.sizex, tile.sizey, tile.col, tile.row)
  }
  window.history.pushState("page", data.title + " - Marx", "/pages/" + data.id);
}

Page.currentEntry = null

Page.updateCurrent = function(target) {
  if(Page.highlightedMenuEntry != null)
    Page.highlightedMenuEntry.removeClass("pure-menu-selected");
  $(target).parent().addClass("pure-menu-selected");
  Page.highlightedMenuEntry = $(target).parent();
}

$().ready(function() {
  $(".page_link").on('click', function(ev) {
    Page.show(ev.target.dataset.id, function(data) {
      Page.updateCurrent(ev.target);
      Page.render(data)
    })
    return false;
  });

  $(".new_page").on('click', function(ev) {
    Page.create(new function(data){
      $(".page_list").append("<li><a href='#' class='page_link' data-id='"
        + data['id']
        +"'>Untitled</a></li>")
      $('.page_list').last().first().get().click()
      console.log(data['id'])
    })
    return false;
  });

  if(window.location.pathname.indexOf("/pages/") >= 0) {
    var id = window.location.pathname.replace("/pages/","")
    var li = $('.page_list li').find("[data-id='" + id + "']")
    Page.updateCurrent(li)
    Page.show(id, Page.render)
  }
})

