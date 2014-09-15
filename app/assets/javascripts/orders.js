$(document).ready(function () {


// put in price slider
  $("#price_slider").slider({});

  var deliveryAddress = $('#delivery-address');
  var paymentInformation = $('#payment-info');

  $('input[name="order_type"]').on('change', function () {
    var status = this.value;

    if (status === 'pickup') {
      deliveryAddress.addClass('hidden');
    }

    if (status === 'delivery') {
      deliveryAddress.removeClass('hidden');
    }

  });

  $('input[name="payment_type"]').on('change', function () {
    var status = this.value;

    if (status === 'pay_in_store') {
      paymentInformation.addClass('hidden');
    }

    if (status === 'pay_online') {
      paymentInformation.removeClass('hidden');
    }

  });




});
