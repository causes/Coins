$ = jQuery;

$(document).ready(function () {
  // listen for coin clicks
  $('#todays_chips').click(function(event) {
    // check that click was on a coin
    if( $(event.target).hasClass('coin_img') ) {

      // remove coin
      var chip_id = $(event.target).attr('id').split('_')[1];
      var url = '/chips/auto_destroy?chip=' + chip_id;

      $.ajax({
        type: 'POST',
        url: url,
        success: function(resp) {
          $('#chip_' + chip_id).remove();
        }
      });
    }
  });

  $('#todays_chips table td').mouseenter(function(event) {
    $(event.target).find('.create_chip').css('visibility', '');
  });

  $('#todays_chips table td').mouseleave(function(event) {
    $('.create_chip').css('visibility', 'hidden');
  });
  
  $('.create_chip').click(function (o) {
    var p = $(this).siblings();
    var arr = p.attr('id').split('_');
    var user_id = arr[1];
    var category_id = arr[3];

    var url = '/chips/auto_create?category=' + category_id + '&user=' + user_id;

    $.ajax({
      type: 'GET',
      url: url,
      success: function(coin_id) {
        create_coin(coin_id, user_id, category_id);
      }  
    });
  });

  $('.create_chip').css('visibility', 'hidden');
});

function create_coin(chip_id, user_id, category_id) {
  var container = $('#user_' + user_id + '_category_' + category_id + '_coins');
  var new_coin = $('<img id="chip_' + chip_id + '" class="coin_img" src="images/coin.png" width="24" height="24"/>');
  container.append(new_coin);
}
