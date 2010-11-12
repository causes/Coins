$ = jQuery;

$(document).ready(function () {
  chips_data = get_data();
  chip_elems = {};

  COIN_IMG = '<img src="images/coin.png" height="12" width="12"/>';
  CHIP_SPAN = '<span id="user_{USER_ID}_category_{CATEGORY_ID}_chips" class="chips"></span>';

  // grid settings
  var cols = 6, x_pad = 5, y_pad = 5;
  
  // position user and category elems
  var user_elems = $('#user_select div.user');
  var cat_elems = $('#category_select div.category');

  $([user_elems, cat_elems]).each(function(i, elems) {
    var p = elems.first().parent();
    var h = elems.first().height();
    var num_rows = Math.ceil(elems.size() / cols);
    position_in_grid(elems, cols, x_pad, y_pad);
    p.css('height', (h + y_pad) * num_rows);
  });
 
  // track selected user and category
  var selected = {
    'user': null,
    'category': null
  };

  // key nav
  $('#user_select div, #category_select div')
  .addClass('keynav_box')
  .keynav('keynav_focusbox', 'keynav_box')
  .click(function(event) {
    var elem = $(event.target);
    
    if (elem.hasClass('user')) {
      select_user(elem);
      load_user_chips(elem);
    }
    else {
      select_category(elem);
    }

    // create a chip when both user and category get selected
    if(selected['user'] && selected['category']) {
      var user_id = selected['user'].attr('id').split('_')[1];
      var category_id = selected['category'].attr('id').split('_')[1];

      var url = '/chips/auto_create?category=' + category_id + '&user=' + user_id;

      $.ajax({
        type: 'GET',
        url: url,
        success: function(resp) {
          if (resp == "fail") {
            alert('You must be approved to create chips');
            return;
          }

          create_coin(resp, user_id, category_id);
        }  
      });
    } 
  });

  // highlight the first user
  $('#user_select div:first').removeClass('keynav_box')
    .addClass('keynav_focusbox');

  // selects a user box
  function select_user(elem) {
    $('#user_select div.user').removeClass('keynav_selected');

    selected['category'] = null;
    $('.category').removeClass('keynav_selected');

    selected['user'] = elem;
    elem.removeClass('keynav_focusbox').addClass('keynav_selected');
  }

  // selects a category box
  function select_category(elem) {
    selected['category'] = elem;
  }

  // creates a coin image
  function create_coin(coin_id, uid, cid) {
    var img = $(COIN_IMG); 
    var chip_span = $('#user_'+uid+'_category_'+cid+'_chips');

    if(chip_span.size() == 0) {
      // need to create span
      chip_span = $(fill_chip_span(uid, cid));
    }
    
    chip_span.append(img);
    $('#category_'+cid+' .category_chips').append(chip_span);

    save_chip_span(chip_span, uid);
  }

  // saves created spans of chips to chip_elems
  function save_chip_span(span, uid) {
    var user = get_user(uid);
    var uname = user.login;
    var key = uid + ':' + uname;

    if(chip_elems[key] == null) {
      chip_elems[key] = [];
    }

    chip_elems[key].push(span);
  }

  // displays a user's chips
  function load_user_chips(user_elem) {
    // first hide all other chips
    $('span.chips').css('display', 'none');

    var uid = user_elem.attr('id').split('_')[1];
    var uname = user_elem.find('.user_name:first').html();
    var key = uid + ':' + uname;
    
    if(chip_elems[key] == null) {
      // go through user's chips in chips_data and create spans and imgs for them
      var chip_spans = [];
      var data = chips_data['chips'][key];

      if(data == null) return; // user has no chips
      
      $.each(data, function(k, arr) { // iterate over categories
        var cid = k.split(':')[0];
        var chip_span = $('<span id="user_'+uid+'_category_'+cid+'_chips" class="chips"></span>');

        $.each(arr, function(i, chip) { // iterate over chips in category
          var new_elem = $(COIN_IMG);
          chip_span.append(new_elem);
        });
        
        // append span full of coin images and save that span as well
        $('#category_' + cid + ' span.category_chips').append(chip_span);
        chip_spans.push(chip_span);
      });

      // save the created spans so we don't have to recreate them each time
      chip_elems[key] = chip_spans;
    } 
    else {
      // just show the spans
      $.each(chip_elems[key], function(i, chip_span) {
        chip_span.css('display', '');
      });
    }
  }
  
  // positions elems in a grid
  function position_in_grid(elems, cols, x_pad, y_pad) {
    // assumes all elems are the same size
    var dx = elems.first().width() + x_pad,
    dy = elems.first().height() + y_pad,
    _top = 0, left = 0; // top is a keyword

    elems.each(function(i, elem) {
      _top = (i != 0 && i % cols == 0) ? _top + dy : _top;
      left = (i % cols == 0) ? 0 : left + dx;

      $(elem).css('left', left).css('top', _top);
    });
  }

  function fill_chip_span(uid, cid) {
    return CHIP_SPAN.replace('{USER_ID}', uid)
    .replace('{CATEGORY_ID}', cid);
  }

  function get_user(uid) {
    var result = $.grep(chips_data['users'], function(o, i) {
      return o.id == uid;
    });

    if(result.length > 0) return result[0];
    return null;
  }
});
