# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".datepicker").datepicker
    dateFormat: 'yy-mm-dd'

$ ->
  $('.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday').sortable
    items: '.item'
    connectWith: ".connectedSortable"

    update: (e, ui) ->
      item = ui.item
      item_data = item.data()
      params = { _method: 'patch' }
      params[item_data.modelName] = { order_position: item.index()-1, wday: item.parent().index()-5 }
      $.ajax
        type: 'POST'
        url: item_data.updateUrl
        dataType: 'json'
        data: params
