# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_book').on 'submit', (event) ->
    event.preventDefault()

    $.post '/books', $(this).serialize(), (books) ->
      console.log books