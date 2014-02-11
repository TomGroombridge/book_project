$(document).ready(function() {
//Set the carousel options
  $('#quote-carousel').carousel({
    pause: true,
    interval: false,
  });

  $("#quote-carousel").swiperight(function() {
    $(this).carousel('prev');
  });

  $("#quote-carousel").swipeleft(function() {
    $(this).carousel('next');
  });
});