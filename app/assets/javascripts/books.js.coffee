# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_book').on 'submit', (event) ->
    event.preventDefault()

    $.post '/books', $(this).serialize(), (books) ->
      console.log books
      
      $(".panel-image img")[0].src = books[0].image_url
      $('.panel-body h2')[0].innerText = books[0].title
      $('.panel-body h4')[0].innerText = books[0].author

  $("#choose_another").on "click", ->
    alert "hello"

  find_selected_number()