# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#book_title').autocomplete({ source: '/suggestions.json', minLength: 5, autoFocus: false })
  $('.quotes').quovolver(500, 5000)