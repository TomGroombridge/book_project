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
    book.find('p').html(book_desc )
    
    book.data('book-index', index)
    bookId = book.attr("data-book-id")
    $('#book'+bookId).val books[index].id


  $('.book').on 'click', '.close', (event) ->
    event.preventDefault()
    $book = $(this).closest('.book')

    $book.find('img').attr('src', '')
    $book.attr('data-filled', false)

  $('.new_book').on 'submit', (event) ->
    event.preventDefault()
    return unless $("#book_title").val()

    data =  $(this).serialize()

    $("#book_title").val ''

    $.post '/books', data, (books) ->
      if books.error
        alert("No book found with that title")
      else
        $emptyBook = $('.book[data-filled="false"]:visible:first')


        bookView(books, $emptyBook, 0)
        bookId = $emptyBook.attr("data-book-id") 
        $('.book'+bookId).val books[0].id

        $emptyBook.attr('data-filled', true)
        $emptyBook.data('all-books', books)
        

        $("#sidebar-wrapper").toggleClass("active")


        $("#book_title").attr("placeholder", 'and another...')

        if $emptyBook.data('book-id') == 3
          $('#book_title').width(100)
          $('#book_title').val 'SUBMIT'
          $('#book_title').background-color(blue)
          $("#tweeting").toggleClass("tweetnow")


 
        $(".book-title").val " "

  $(".btn-success, .next_book").on "click", ->
    $currentBook = $(this).closest('.book')
    books = $currentBook.data('all-books')
    newIndex = $currentBook.data('book-index') + 1

    if !books[newIndex]
      newIndex = 0

    bookView(books, $currentBook, newIndex) 



