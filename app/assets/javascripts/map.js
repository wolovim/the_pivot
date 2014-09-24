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