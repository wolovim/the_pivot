$(document).ready(function () {

  var deliveryAddress = $('#delivery-address');
  var paymentInformation = $('#payment-info');

  var list_of_items = [];
  var filters = {};
  function getItems(page) {
    $.get('/items.json',
      function(data, statusCode) {
        if (statusCode == 'success') {
          $.each(data, function(index, item) {
            list_of_items.push(item);
            renderItem( item );
          });
        } else {
          console.log( statusCode, data );
        }
      }
    );
  }

  $(".listings").html('');
  getItems(1);

  function renderItem(item) {
    $(".listings").append('<div class="thumbnail col-lg-3">' +
      '<img src="http://static.pexels.com/wp-content/uploads/2014/08/couch-flat-home-2459-525x350.jpg">' +
      '<div class="caption">' +
        '<h5><a href="'+ item.path +'">'+item.title+'</a></h5>' +
        '<p>$'+item.price+'</p>' +

        // fix below, how not to pass authenticity token?
        '<form action="/orders/25/add_item?item_id='+item.id+'" class="button_to" method="post">'+
        '<input name="authenticity_token" type="hidden" value="ok/cMuVXVTaGgCMLmt58c4VIKP7BiANFFw6Hz75r3Pg="></div></form>' +

      '</div>' +
    '</div>');
  }

  function checkMyDateWithinRange(myDate, start, end){
    var startDate = new Date(start);
    var endDate = new Date(end);     
    if (startDate < myDate && myDate < endDate) {
       return true; 
    }
    return false;
  }

  function filterItems() {
    $(".listings").html('');
    $.each(list_of_items, function(index, item) {
      var shouldBeVisible = true;
      $.each(filters, function(key, value) {
        // filters["price"] = [1000, 4000];
        // item["price"] = 3000;
        if (Array.isArray(value)) {
          if (value[0] > item[key] || value[1] < item[key]) {
            shouldBeVisible = false;
          }
        }

        if (key === "bathroom") {
          if (filters[key] !== item[key]) {
            shouldBeVisible = false;
          }
        }

        if (key === "date_filter") {
          var availabilities = item.availabilities
          var checkin = filters[key].checkin
          var checkout = filters[key].checkout

          var requestedDateArray = getDateArray(new Date(checkin), new Date(checkout));
          
          var availableDateArray = availabilities.map(function(obj) { 
            return new Date(obj["date"]).getTime(); 
          });

          var counter = 0;
          for (i = 0; i < requestedDateArray.length; i++) {
            var date = requestedDateArray[i];
            for (j = 0; j < availableDateArray.length; j++) {
              if (date === availableDateArray[j]) {
                counter++;
              }
            }
          }
          if (counter !== requestedDateArray.length) {
            shouldBeVisible = false;
          }
        }        
      });

      if (shouldBeVisible === true) {
        renderItem( item );
      }
    });
  }

  function getDateArray( d1, d2 ){
    var oneDay = 24*3600*1000;
    for (var d=[],ms=d1*1,last=d2*1;ms<last;ms+=oneDay){
      d.push( new Date(ms).getTime() );
    }
    return d;
  }

  $(".btn-group.bathrooms button").on("click", function(event) {
    var filter_id = $(this).attr('id');
    var was_selected = $(this).hasClass('active');
    $(".btn-group.bathrooms button").removeClass('active');

    if(was_selected) {
      $(this).blur();
      delete filters["bathroom"]
    } else {
      $(this).addClass('active');
      filters["bathroom"] = filter_id;
    }
    filterItems();
  });

  $(".btn-group-vertical.accommodations button").on("click", function(event) {
    var filter_id = $(this).attr('id');
    var was_selected = $(this).hasClass('active');
    $(".btn-group-vertical.accommodations button").removeClass('active');

    if(was_selected) {
      $(this).blur();
      delete filters["accommodation"]
    } else {
      $(this).addClass('active');
      filters["accommodation"] = filter_id;
    }
    filterItems();
  });

  $(".date-picker[type='date']").on("change", function (event) {
    var checkin = $("input[name='checkin']").val();
    var checkout = $("input[name='checkout']").val();
    if(checkin && checkout) {
      filters["date_filter"] = {
        checkin: checkin,
        checkout: checkout
      }
    } else {
      delete filters["date_filter"]
    }
    filterItems();
  });

  //
  // $(".btn-group.people_per_unit button").on("click", function(event) {
  //   var filter_id = $(this).attr('id');
  //   $(".btn-group.people_per_unit button").removeClass('active');
  //   $(this).addClass('active');
  //   filters["people_per_unit"] = filter_id;
  //   filterItems();
  // });

  $(".dropdown.people_per_unit li").on("click", function(event) {
    var filter_id = $(this).attr('id');
    filters["people_per_unit"] = filter_id;
    filterItems();
  });

  // $(".btn-group.price-range").on("change", function() {
  //   // Fix for price range
  //   var min = $("#btn-range-min").value,
  //       max = $("#btn-range-max").value;
  //   filters["price"] = [min, max];
  //   filterItems();
  // });


});
