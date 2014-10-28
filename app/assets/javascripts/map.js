function initializeMap(listings){

  var mapProp = {
    center:new google.maps.LatLng(39.749650, -105.000107),
    zoom:12,
    mapTypeId:google.maps.MapTypeId.ROADMAP
    };
  var map=new google.maps.Map(document.getElementById("googleMap")
    ,mapProp);

  allMarkers = _.map(listings, function(listing){
    return new google.maps.Marker({
              position:new google.maps.LatLng(listing.latitude, listing.longitude),
              map:map,
              title: listing.title,
              listingId: listing.id,
            })

  });
}


function filterMapMarkers(validListings) {
  _.each(allMarkers, function(marker){marker.setVisible(false)})
  var validListingIds = _.map(validListings, function(listing){ return listing.id})
  var visibleMarkers = _.filter(allMarkers, function(marker){
    return _.contains(validListingIds, marker.listingId);
  });
  _.each(visibleMarkers, function(marker){marker.setVisible(true)})
}
