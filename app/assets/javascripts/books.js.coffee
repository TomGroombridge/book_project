# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  bookView = (books, book, index) ->
    book.find('img').attr('src', books[index].image_url)
    book.find('h2').text(books[index].title)
    book.find('h4').text(books[index].author)
    book_desc = books[index].content
    if book_desc.length > 150
      book_desc = book_desc.substring(0,150) + "..."
    book.find('p').text(book_desc )
    book.data('book-index', index)
    bookId = book.attr("data-book-id")
    $('#book'+bookId).val books[index].id


  $('.new_book').on 'submit', (event) ->
    event.preventDefault()


    $.post '/books', $(this).serialize(), (books) ->
      if books.error
        alert("No book found with that title")
      else
        $emptyBook = $('.book[data-filled="false"]:visible:first')

        bookView(books, $emptyBook, 0)
        bookId = $emptyBook.attr("data-book-id") 
        $('#book'+bookId).val books[0].id

        $emptyBook.attr('data-filled', true)
        $emptyBook.data('all-books', books)
        $("#sidebar-wrapper").toggleClass("active")

        $(".book-title").val " "
        $emptyBook.addClass('magictime vanishIn'); //this is for using the cool css tricks

  $(".btn-success, .next_book").on "click", ->
    $currentBook = $(this).closest('.book')
    books = $currentBook.data('all-books')
    newIndex = $currentBook.data('book-index') + 1

    if !books[newIndex]
      newIndex = 0

    bookView(books, $currentBook, newIndex) 



