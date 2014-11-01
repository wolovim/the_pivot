$(document).ready(function () {

  var $listings = $('.listings');
  var $accomodationsButtons = $('.accommodations button');
  var $peoplePerUnitButtons = $('.people_per_unit button');
  var $bathroomButtons = $('.bathrooms button');
  var $priceButtons = $('.price button');
  var $dateInputs = $(".date-picker[type='date']")
  var $locationField = $("input[type=text]")

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

    $locationField.on('change', function () {
      var location = $(this).val();
      filters.location = function (listing) {
        if (listing.address) {
          return listing.address.city === location;
        }
      };
      filterListings(listings);
    });

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
      var price = this.innerHTML;
      filters.price = function (listing) {
        if (price === '$') {
          return listing.price < 5100;
        }
        else if (price === '$$') {
          return listing.price >= 5100 && listing.price < 10000;
        }
        else if (price === '$$$') {
          return listing.price >= 10000 && listing.price < 15000;
        }
        else if (price === '$$$$') {
          return listing.price >= 15000;
        }
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
      return '<div class="thumbnail col-lg-3">' + '<img src="'+ listing.item_images[0].json_image_link +'">' +
      '<div class="caption" style="margin-top: -295px;">' +
        '<div class="caption">' +
          '<br/><br/><br/><h5 style="display: inline-block; background: white; margin-left: -20px; padding: 5px;"><a href="'+ listing.path +'">'+ listing.title +'</a></h5>' +
          '<br/><br/><br/><br/><br/><br/><br/><p style="display: inline-block; margin-left: 157px; background: white; padding: 3px; font-weight: bold;">$'+ listing.price/100 +'</p>' +
        '</div>' +
      '</div>'
    });

    $listings.empty();
    $listings.append(listingElements);
  }

  });
