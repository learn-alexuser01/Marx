Page = {}
Page.current = null
Page.highlightedMenuEntry = null
Page.removedTileIds = Array()

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

function copyTile(tile) {
  return {
    sizex: tile.sizex,
    sizey: tile.sizey,
    row: tile.row,
    col: tile.col,
    title: tile.title,
    caption: tile.caption,
    id: tile.id
  }
}
Page.update = function(id, callback, page, newTiles, updatedTiles, removedTileIds) {
  var n = new Array();
  for(var i = 0; i < newTiles.length; i++) {
    n[i] = copyTile(newTiles[i])
  }

  var u = new Array();
  for(var i = 0; i < updatedTiles.length; i++) {
    u[i] = {
      id: updatedTiles[i].id,
      tile: copyTile(updatedTiles[i])
    }
  }

  var updates = {
    page: page,
    tiles: {
      new: n,
      updated: u,
      deleted: Page.removedTileIds
    }
  }
  $.ajax({
    type: "PUT",
    url: '/pages/'+ id + '.json',
    data: JSON.stringify(updates),
    contentType: 'application/json', // format of request payload
    dataType: 'json', // format of the response
    success: callback
  });
}

// callback receives nothing
Page.delete = function(id, callback) {
  $.post('/pages/' + id + '.json', {
    _method: 'DELETE'
  }, callback)
}


Page.render = function(data) {
  Page.current = data
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
        '</li>', tile.sizex, tile.sizey, tile.col, tile.row).data('id', tile.id)
  }
  gridster.disable()
  window.history.pushState("page", data.title + " - Marx", "/pages/" + data.id);
}

Page.updateCurrent = function(target) {
  if(Page.highlightedMenuEntry != null)
    Page.highlightedMenuEntry.removeClass("pure-menu-selected");
  $(target).parent().addClass("pure-menu-selected");
  Page.highlightedMenuEntry = $(target).parent();
}

Page.edit = function() {
  var gridster = $('.gridster ul').gridster().data('gridster')
  gridster.enable();
  $('.gridster li').each(function(index, tile) {
    console.log(Page.current.tiles[index].sizex)
    tile.innerHTML = '<div class="tile-bg-url pure-form pure-form-stacked" style="; width: '+
      (200 * Page.current.tiles[index].sizex - 10)+
      'px; height: '+
      (200 * Page.current.tiles[index].sizey - 10)+
      'px; background: #111111;" ><input type="text" name="title" placeholder="Title or URL" value="'+
      Page.current.tiles[index].title+'" style="display:table-cell; width:100%"></input>' +
      '<textarea style="display:table-cell; width:100%" name="caption" placeholder="Text or Caption">'+Page.current.tiles[index].caption+'</textarea>' +
      '<button class="page-delete" style="background: none; border:none !important; position: absolute; bottom:0;right:0;"><img src="/x-button.png" /></button></div>'
  })
  $('.page-delete').on('click', Page.removeTile)
  $('#page-add').show()
  $('#page-edit').html("Save")
  $("#page-add").on('click', function(ev) {

  var newWidget = '<li><div class="tile-bg-url pure-form pure-form-stacked" style="; width: '+
      (200 * 1 - 10)+
      'px; height: '+
      (200 * 1 - 10)+
      'px; background: #111111;" ><input type="text" name="title" placeholder="Title or URL" style="display:table-cell; width:100%"></input>' +
      '<textarea style="display:table-cell; width:100%" name="caption" placeholder="Text or Caption"></textarea>' +
      '<button class="tmp-page page-delete" style="background: none; border:none !important; position: absolute; bottom:0;right:0;"><img src="/x-button.png" /></button></div></li>'
    gridster.add_widget($(newWidget))

    $('.page-delete').on('click', Page.removeTile)
  })
}

Page.removeTile = function(ev) {
  var gridster = $('.gridster ul').gridster().data('gridster')
  var li = $(ev.target).parent().parent()
  if(!li.is('li'))
    li = li.parent()
  gridster.remove_widget(li)
  if(li.data('id') != null) {
    Page.removedTileIds.push(li.data('id'))
  }
}

Page.save = function() {
  var updatedTiles = []
  var newTiles = []
  $('.gridster li').each(function(index, tile) {
    var data = $(tile).data()
    data.title = $($(tile).children()[0]).children("[name='title']").val()
    data.caption = $($(tile).children()[0]).children("[name='caption']").val()
    console.log(data)
    if(data.id == null)
      newTiles.push(data)
    else
      updatedTiles.push(data)
  })
  var p= {id: Page.current.id, title: Page.current.title}
  Page.update(Page.current.id, function(){}, p, newTiles, updatedTiles, Page.removedTileIds);
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
    })
    return false;
  });

  Page.editButtonDoStuff = Page.editButtonNormalMode;

  $("#page-edit").on('click', function(ev) {
    Page.editButtonDoStuff();
  })

  if(window.location.pathname.indexOf("/pages/") >= 0) {
    var id = window.location.pathname.replace("/pages/","")
    var li = $('.page_list li').find("[data-id='" + id + "']")
    Page.updateCurrent(li)
    Page.show(id, Page.render)
  }
})

Page.editButtonNormalMode = function () {
  Page.edit();
  Page.editButtonDoStuff = Page.editButtonSaveMode
}

Page.editButtonSaveMode = function () {
  console.log("here");
  Page.save();
  Page.show(Page.current.id, Page.render)
  Page.removedTileIds = []
  $('#page-edit').html("Edit")
  $('#page-add').hide()
  $('#page-add').unbind('click')
  Page.editButtonDoStuff = Page.editButtonNormalMode
}
