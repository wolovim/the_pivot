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
      '<img src="'+item.image_file_name+'">' +
      '<div class="caption">' +

        '<h5><a href="'+ item.path +'">'+item.title+'</a></h5>' +

        '<p>$'+item.price+'</p>' +
        '<form action="/orders/25/add_item?item_id='+item.id+'" class="button_to" method="post"><div><input class="thumbnail-btn btn btn-primary" type="submit" value="Book it!"><input name="authenticity_token" type="hidden" value="ok/cMuVXVTaGgCMLmt58c4VIKP7BiANFFw6Hz75r3Pg="></div></form>' +
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
    $(".btn-group.bathrooms button").removeClass('active');
    $(this).addClass('active');
    filters["bathroom"] = filter_id;
    // To remove a filter:
    // delete filters["bathroom"];
    filterItems();
  });

  $(".btn-group.accommodations button").on("click", function(event) {
    var filter_id = $(this).attr('id');
    $(".btn-group.accommodations button").removeClass('active');
    $(this).addClass('active');
    filters["accommodation"] = filter_id;
    // To remove a filter:
    // delete filters["bathroom"];
    filterItems();
  });

  $(".btn-group.price-range").on("change", function() {
    // Fix for price range
    var min = $("#btn-range-min").value,
        max = $("#btn-range-max").value;
    filters["price"] = [min, max];
    filterItems();
  });


});
