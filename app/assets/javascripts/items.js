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
      // '<img src="http://static.pexels.com/wp-content/uploads/2014/08/couch-flat-home-2459-525x350.jpg">' +
      '<img src="'+ item.item_images +'">' +
      '<div class="caption">' +
        '<h5><a href="'+ item.path +'">'+ item.title +'</a></h5>' +
        '<p>$'+ item.price +'</p>' +
        // fix below, how not to pass authenticity token?
        // '<form action="/orders/25/add_item?item_id='+item.id+'" class="button_to" method="post">'+
        // '<input name="authenticity_token" type="hidden" value="ok/cMuVXVTaGgCMLmt58c4VIKP7BiANFFw6Hz75r3Pg="></div></form>' +
      '</div>' +
    '</div>');
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
        } else if (filters[key] !== item[key]) {
          shouldBeVisible = false;
        }
      });
      if (shouldBeVisible === true) {
        renderItem( item );
      }
    });
  }

  $(".btn-group.bathrooms button").on("click", function(event) {
    var filter_id = $(this).attr('bathroom');
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
    var filter_id = $(this).attr('accommodation');
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

  $(".btn-group.people_per_unit button").on("click", function(event) {
    var filter_id = $(this).attr('people_per_unit ');
    var was_selected = $(this).hasClass('active');
    $(".btn-group.people_per_unit button").removeClass('active');

    if(was_selected) {
      $(this).blur();
      delete filters["people_per_unit"]
    } else {
      $(this).addClass('active');
      filters["people_per_unit"] = filter_id;
    }
    filterItems();
  });

  // $(".dropdown.people_per_unit li").on("click", function(event) {
  //   var filter_id = $(this).attr('id');
  //   filters["people_per_unit"] = filter_id;
  //   filterItems();
  // });

  $(".btn-group.price button").on("click", function(event) {
    var filter_id = $(this).attr('price');
    var was_selected = $(this).hasClass('active');
    $(".btn-group.price button").removeClass('active');

    if(was_selected) {
      $(this).blur();
      delete filters["price"]
    } else {
      $(this).addClass('active');
      filters["price"] = filter_id;
    }
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

$(document).ready(function() {
  function initialize()
  {
  var mapProp = {
    center:new google.maps.LatLng(39.749650, -105.000107),
    zoom:13,
    mapTypeId:google.maps.MapTypeId.ROADMAP
    };
  var map=new google.maps.Map(document.getElementById("googleMap")
    ,mapProp);

  var point = new google.maps.LatLng(39.749650, -105.000107);
  var point2 = new google.maps.LatLng(39.750137, -104.997466);

  var marker = new google.maps.Marker({
      position:point,
      map:map,
      title:'Jorge\'s Couch',
    })

  var marker = new google.maps.Marker({
      position:point2,
      map:map,
      title:'Rachel\'s Futon',
    })

  }

  // google.maps.event.addDomListener(window, 'load', initialize);
  initialize();
});
