# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_book').on 'submit', (event) ->
    event.preventDefault()

    $.post '/books', $(this).serialize(), (books) ->
      console.log books
      
      $(".panel-image img")[2].src = books[2].image_url
      $('.panel-body h2')[2].innerText = books[2].title
      $('.panel-body h4')[2].innerText = books[2].author

  $(".btn-success, .next_book").on "click", ->
    alert "hello"

  find_selected_number()