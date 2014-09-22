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
    $(this).addClass('active');
    filters["accommodation"] = filter_id;
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
