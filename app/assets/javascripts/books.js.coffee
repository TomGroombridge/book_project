# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  bookView = (books, book, index) ->
    book.find('img').attr('src', books[index].image_url)
    book_title = books[index].title
    if book_title.length > 100 
      book_title = book_title.substring(0,100) + "..."
    book.find('h2').text(book_title)
    
    book.find('h4').text(books[index].author)
    book_desc = books[index].content
    if book_desc.length > 150
      book_desc = book_desc.substring(0,150) + "..."
    book.find('p').text(book_desc )
    
    book.data('book-index', index)
    bookId = book.attr("data-book-id")
    $('#book'+bookId).val books[index].id


# this bit of code is for using a special text editor on the search bar
# $("#book_title").fancyInput();






# this code is what happens when you hit submit after entering a title
  $('#new_book').on 'submit', (event) ->
    event.preventDefault()


    $.post '/books', $(this).serialize(), (books) ->
      if books.error
        alert("No book found with that title")
      else
        $emptyBook = $('.book[data-filled="false"]:first')

        bookView(books, $emptyBook, 0)
        bookId = $emptyBook.attr("data-book-id")
        $('#book'+bookId).val books[0].id

        $emptyBook.attr('data-filled', true)
        $emptyBook.data('all-books', books)
        $emptyBook.addClass('magictime vanishIn'); #this is for using the cool css tricks
        $("#book_title").val " "

  $(".btn-success, .next_book").on "click", ->
    $currentBook = $(this).closest('.book')
    books = $currentBook.data('all-books')
    newIndex = $currentBook.data('book-index') + 1

    if !books[newIndex]
      newIndex = 0

    bookView(books, $currentBook, newIndex) 
