$(function() {

  $('#new-joke').on('click', function(event) {
    event.preventDefault();

    $.get('/new-joke.json', function(data) {
      $('.panel').text(data["joke"]);
    });
  });

});
