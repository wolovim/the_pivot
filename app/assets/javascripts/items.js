$(document).ready(function () {

  var $listings = $('.listings');
  var $accomodationsButtons = $('.accommodations button');
  var $peoplePerUnitButtons = $('.people_per_unit button');
  var $bathroomButtons = $('.bathrooms button');
  var $priceButtons = $('.price button');

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
      var price = this.innerHTML;
      filters.price = function (listing) {
        return listing.price === price;
      };
      filterListings(listings);
    });
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
      return '<div class="thumbnail col-lg-3">' +
        '<div class="caption">' +
          '<h5><a href="'+ listing.path +'">'+ listing.title +'</a></h5>' +
          '<p>$'+ listing.price +'</p>' +
        '</div>' +
      '</div>'
    });

    $listings.empty();
    $listings.append(listingElements);
  }

});
