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
  $('.gridster ul').empty()
}

Page.currentEntry = null

Page.updateCurrent = function(ev) {
  if(Page.highlightedMenuEntry != null)
    Page.highlightedMenuEntry.removeClass("pure-menu-selected");
  $(ev.target).parent().addClass("pure-menu-selected");
  Page.highlightedMenuEntry = $(ev.target).parent();

}

$().ready(function() {
  $(".page_link").on('click', function(ev) {
    Page.show(ev.target.dataset.id, function(data) {
      Page.updateCurrent(ev);
      Page.render(data)
    })
    return false;
  });
})

