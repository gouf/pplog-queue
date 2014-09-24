function fadeOut(elm) {
  $(elm).fadeOut('slow', function() {
    console.log('Faded out.');
    $(elm).detach();
  });
}
$('.post').click(function() {
  var id = $(this).children('.id').text()
  console.log(id);
  var url = '/post'
  $.ajax({
    type: 'POST',
    url: url,
    data: {
      id: id
    },
    success: fadeOut($(this))
  });
});

$(document).ready( function() {
  // Remove notification box if already posts stocked.
  var postStockSize = $('.post').size();
  if (postStockSize != 0) {
    $('.mock-post').detach();
  }
});
