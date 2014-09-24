$(document).ready(function () {

  var $listings = $('.listings');
  var $accomodationsButtons = $('.accommodations button');
  var $peoplePerUnitButtons = $('.people_per_unit button');
  var $bathroomButtons = $('.bathrooms button');
  var $priceButtons = $('.price button');
  var $dateInputs = $(".date-picker[type='date']")

  var filters = {
    peoplePerUnit: null,
    accommodations: null,
    price: null,
    bathroom: null,
    location: null,
    availablilities: null
  };

  $.getJSON('/items.json').done(function (listings) {

    renderListings(listings);

    $accomodationsButtons.on('click', function () {
      $accomodationsButtons.removeClass('active');
      $(this).addClass('active');
      var accommodation = this.innerHTML;
      filters.accommodations = function (listing) {
        return listing.accommodation === accommodation;
      };
      filterListings(listings);
    });

    $peoplePerUnitButtons.on('click', function () {
      $peoplePerUnitButtons.removeClass('active');
      $(this).addClass('active');
      var peoplePerUnit = parseInt(this.innerHTML, 10);
      filters.peoplePerUnit = function (listing) {
        return listing.people_per_unit === peoplePerUnit;
      };
      filterListings(listings);
    });

    $bathroomButtons.on('click', function () {
      $bathroomButtons.removeClass('active');
      $(this).addClass('active');
      var bathroom = this.innerHTML;
      filters.bathroom = function (listing) {
        return listing.bathroom === bathroom;
      };
      filterListings(listings);
    });

    $priceButtons.on('click', function () {
      $priceButtons.removeClass('active');
      $(this).addClass('active');
      var price = parseInt(this.innerHTML, 10);
      filters.price = function (listing) {
        return listing.price === price;
      };
      filterListings(listings);
    });
    
    $dateInputs.on("change", function (event) {
      var checkin = $("input[name='checkin']").val();
      var checkout = $("input[name='checkout']").val();
      if(checkin && checkout) {
        filters.availabilities = function (listing) {
          var requestedDateArray = getDateArray(new Date(checkin), new Date(checkout));
          var availabilities = listing.availabilities
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
          return counter === requestedDateArray.length
        }
      }
      filterListings(listings);
    });

    filterListings(listings);

    function getDateArray( d1, d2 ){
      var oneDay = 24*3600*1000;
      for (var d=[],ms=d1*1,last=d2*1;ms<last;ms+=oneDay){
        d.push( new Date(ms).getTime() );
      }
      return d;
    }

    function checkMyDateWithinRange(myDate, start, end){
      var startDate = new Date(start);
      var endDate = new Date(end);     
      if (startDate < myDate && myDate < endDate) {
         return true; 
      }
      return false;
    }

  });

  function filterListings(listings) {
    var validListings = listings;

    _.values(filters).forEach(function (filter) {
      if (filter !== null) validListings = validListings.filter(filter);
    });

    renderListings(validListings);
  }

  function renderListings(listings) {
    var listingElements = listings.map(function (listing) {
      // debugger
      return '<div class="thumbnail col-lg-3">' + '<img src="'+ listing.item_images[0].json_image_link +'">' +
      '<div class="caption">' +
        '<div class="caption">' +
          '<h5><a href="'+ listing.path +'">'+ listing.title +'</a></h5>' +
          '<p>$'+ listing.price +'</p>' +
        '</div>' +
      '</div>'
    });

    // function renderItem(item) {
    // $(".listings").append('<div class="thumbnail col-lg-3">' +
    //   '<img src="http://static.pexels.com/wp-content/uploads/2014/08/couch-flat-home-2459-525x350.jpg">' +
    //   '<div class="caption">' +
    //     '<h5><a href="'+ item.path +'">'+item.title+'</a></h5>' +
    //     '<p>$'+item.price+'</p>' +

    //     // fix below, how not to pass authenticity token?
    //     '<form action="/orders/25/add_item?item_id='+item.id+'" class="button_to" method="post">'+
    //     '<input name="authenticity_token" type="hidden" value="ok/cMuVXVTaGgCMLmt58c4VIKP7BiANFFw6Hz75r3Pg="></div></form>' +

    //     '</div>' +
    //   '</div>');
    // } 

    $listings.empty();
    $listings.append(listingElements);
  }

  //   if(was_selected) {
  //     $(this).blur();
  //     delete filters["accommodation"]
  //   } else {
  //     $(this).addClass('active');
  //     filters["accommodation"] = filter_id;
  //   }
  //   filterItems();
  // });

  });
