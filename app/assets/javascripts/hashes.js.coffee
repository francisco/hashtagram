# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#search').click ->
    event.preventDefault()

    query = $('#query').val()
    $.ajax(
      type: "GET",
      url: "/hashes.json?search="+ query
    ).done (data) ->
      console.log data
      $('.hashes').empty()
      $('.hashes').append JST["templates/hashes"](tags : data.frequencies || [])

      dataShit = data["chart"]
      $('#myfirstchart').empty()
      new Morris.Bar(
        element: "myfirstchart"
        data: dataShit
        xkey: "keyword"
        ykeys: ["value"]
        labels: ["Keyword"]
      )


