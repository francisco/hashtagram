# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#search').click ->
    event.preventDefault()
    query = $('#query').val()
    $.ajax("/hashes.json?search="+ query,
      type: "GET").done (data) ->
      console.log data

