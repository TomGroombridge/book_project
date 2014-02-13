# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  bookView = (books, book, index) ->
    book.find('.spinner').hide()
    book.find('.image-box').css('display', 'inline-block')

    book.find('.panel-image-preview').attr('src', books[index].image_url)
    book_title = books[index].title
    if book_title.length > 100 
      book_title = book_title.substring(0,100) + "..."
    book.find('h2').text(book_title)
    
    book.find('h4').text(books[index].author)
    book_desc = books[index].content
    # if book_desc.length > 250
    #   book_desc = book_desc.substring(0,250) + "..."
    book.find('p').html(book_desc)
    
    book.data('book-index', index)
    bookId = book.attr("data-book-id")
    $('#book'+bookId).val books[index].id


  $('.book').on 'click', '.delete_book', (event) ->
    event.preventDefault()
    $book = $(this).closest('.book')

    $book.find('.panel-image-preview').attr('src', '')
    $book.attr('data-filled', false)

    console.log($book.find('.image-box'))
    $book.find('.image-box').hide()
    $book.find('h3').slideDown()
    $("#book_title").val('')
    $("#book_title").attr("placeholder", 'and another...')

    $("#book_title").removeClass('cat').off('click')


  $('.new_book').on 'submit', (event) ->
    event.preventDefault()
    return unless $("#book_title").val()

    data =  $(this).serialize()

    $("#book_title").val ''
    $emptyBook = $('.book[data-filled="false"]:visible:first')
    $emptyBook.find('h3').slideUp()

    $emptyBook.find('.spinner').show()

    $.post '/books', data, (books) ->
      if books.error
        alert("Yikes, we couldn't find that title, please try again using the following format 'title' by 'author'")
        $emptyBook.find('.spinner').hide()
        $emptyBook.find('h3').slideDown()
        return
      else

        bookView(books, $emptyBook, 0)
        bookId = $emptyBook.attr("data-book-id") 
        $('.book'+bookId).val books[0].id

        $emptyBook.attr('data-filled', true)
        $emptyBook.data('all-books', books)
        

        $("#sidebar-wrapper").click


        $("#book_title").attr("placeholder", 'and another...')

        if $emptyBook.data('book-id') == 3
          $('#book_title').blur();
          $('#book_title').attr("style", 'text-align: center')
          # $('#book_title').attr('disabled', true);
          $('#book_title').width($(window).width() * 0.37)
          $('#book_title').val 'SHARE MY BOOKS'
          $('#book_title').addClass("cat")
          # $('#book_title').css( 'cursor', 'pointer' );
          $('.cat').on 'click', ->
            $('#buttons button').click()


 
        $(".book-title").val " "

  $(".btn-success, .next_book").on "click", ->
    $currentBook = $(this).closest('.book')
    books = $currentBook.data('all-books')
    newIndex = $currentBook.data('book-index') + 1

    if !books[newIndex]
      newIndex = 0

    bookView(books, $currentBook, newIndex) 
