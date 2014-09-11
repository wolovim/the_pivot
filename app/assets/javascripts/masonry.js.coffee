$ ->
  $('.listings').imagesLoaded ->
    $('.listings').masonry
      itemSelector: '.each_listing'
      isFitWith: true
