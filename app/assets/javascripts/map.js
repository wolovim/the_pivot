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
  var point3 = new google.maps.LatLng(39.7584647, -104.9969655);
  var point4 = new google.maps.LatLng(39.735939, -104.902641);
  var point5 = new google.maps.LatLng(39.7335358, -104.9926147);
  var point6 = new google.maps.LatLng(39.759608, -105.0113764);

  // var point2 = new google.maps.LatLng(39.750137, -104.997466);
  // var point2 = new google.maps.LatLng(39.750137, -104.997466);
  // var point2 = new google.maps.LatLng(39.750137, -104.997466);
  // var point2 = new google.maps.LatLng(39.750137, -104.997466);
  //



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

  var marker = new google.maps.Marker({
      position:point3,
      map:map,
      title:'Listing',
    })

  var marker = new google.maps.Marker({
      position:point4,
      map:map,
      title:'Listing',
    })

  var marker = new google.maps.Marker({
      position:point5,
      map:map,
      title:'Listing',
    })

  var marker = new google.maps.Marker({
      position:point6,
      map:map,
      title:'Listing',
    })

  }

  // google.maps.event.addDomListener(window, 'load', initialize);
  initialize();
});
