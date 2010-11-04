// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$ = jQuery;

$(document).ready(function () {

  // listen for coin clicks
  $('#todays_chips').click(function(event) {

    alert('clicked inside, this is ' + $(this).parent().attr('id'));

    // check that click was on a coin
    if( $(event.target).hasClass('coin_img') ) {
      // remove coin
      var coin = $(event.target);
      var pid = coin.parent().attr('id');
      var arr = pid.split('_');
      var user_id = arr[1];
      var category_id = arr[3];

      var url = '/chips/auto_destroy?user=' + user_id + '&category=' + category_id;
      alert(url);

      $.post({
        url: url,
        success: function(resp) {
          alert(resp);
          // destroy actual coin
          $(this).remove();
        }
      });
    }
  });

  $('.create_chip').click(function (o) {
    var p = $(this).parent();
    var arr = p.attr('id').split('_');
    var user_id = arr[1];
    var category_id = arr[3];

    var url = '/chips/auto_create?category=' + category_id + '&user=' + user_id;

    $.ajax({
      type: 'POST',
      url: url,
      success: function(resp) {
        create_coin(user_id, category_id);
      }
    });
  });
});

function create_coin(user_id, category_id) {
  var container = $('#user_' + user_id + '_category_' + category_id + '_coins');
  var new_coin = $('<img src="images/coin.png" width="24" height="24"/>');

  new_coin.click(function () {
     alert('coin click');
  });

  container.append(new_coin);
}

