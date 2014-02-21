function fadeOut(elm) {
  $(elm).fadeOut('slow', function() {
    console.log('Faded out.');
    $(elm).detach();
  });
}
$('.post').click(function() {
  var id = $(this).children('.id').text()
  console.log(id);
  var url = 'http://localhost:4567/post'
  $.ajax({
    type: 'POST',
    url: url,
    data: {
      id: id
    },
    success: fadeOut($(this))
  });
});

