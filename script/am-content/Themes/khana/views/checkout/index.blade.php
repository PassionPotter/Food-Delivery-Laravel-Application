@extends('theme::layouts.app')

@section('content')

<!-- success-alert start -->
<div class="alert-message-area">
	<div class="alert-content">
		<h4 class="ale">{{ __('Your Settings Successfully Updated') }}</h4>
	</div>
</div>
<!-- success-alert end -->

<!-- error-alert start -->
<div class="error-message-area">
	<div class="error-content">
		<h4 class="error-msg"></h4>
	</div>
</div>
<!-- error-alert end -->

<!-- checkout area start -->
<section>
	<div class="checkout-area">
		<div class="container">
			<div class="row mt-50">
				<div class="col-lg-8">
					<form action="{{ route('order.create') }}" method="POST" autocomplete="off" id="form_payment">
						@csrf
						<div class="single-checkout mb-50">
							@if ($errors->any())
								<div class="alert alert-danger">
									<ul>
										@foreach ($errors->all() as $error)
											<li>{{ $error }}</li>
										@endforeach
									</ul>
								</div>
							@endif
							<h3><span>1</span> {{ __('Delivery Details') }}</h3>

							<h6 class="text-danger none" id="msg">{{ __('Service Not Available On Your Area') }}</h6>

							<div class="delivery-form">
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label for="first_name">{{ __('Name') }}</label>
											<input autocomplete="off" type="text" class="form-control" name="name" id="first_name" placeholder="{{ __('Name') }}" value="{{ Auth::user()->name ?? '' }}">
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label for="phone">{{ __('Phone Number') }}</label>
											<input type="number" class="form-control" name="phone" id="phone" placeholder="{{ __('Phone Number') }}" autocomplete="off" required >
										</div>
									</div>
									{{--@if($ordertype == 1)--}}
									<input type="hidden" name="latitude" id="latitude" value="{{ $resturent_info->resturentlocation->latitude }}">
									<input type="hidden" name="longitude" id="longitude" value="{{ $resturent_info->resturentlocation->longitude }}">

									<div class="col-lg-12">
										<div class="form-group">
											<label for="billing">{{ __('Delivery Address') }}</label>
											<input type="text" class="form-control location_input" autocomplete="off" id="location_input" placeholder="{{ __('Delivery Address') }}" name="delivery_address" required>
										</div>
									</div>

									<input type="hidden" name="orderOption" id="order-option" value="1" />

									<h6 class="text-danger" id="stateMessage">{{ __('You are not in Delivery zones. Please check locations') }}</h6>
									<div class="col-lg-12">
										<div class="form-group">
											<div class="map-canvas" id="map-canvas">
											</div>
											<input type="hidden" name="shipping" id="shipping">
										</div>
									</div>

									{{--@endif--}}
									<div class="col-lg-12">
										<div class="form-group">
											<label for="order_details">{{ __('Order Note') }}</label>
											<textarea class="form-control" name="order_note" id="order_details" cols="5" rows="5" maxlength="200" placeholder="{{ __('Order Note') }}" required></textarea>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="select-payment-area mt-50">
											<h3><span>2</span> {{ __('Select Payment Method') }}</h3>
											<div class="row justify-content-center select_payment">


												<div class="col-sm-4 payment_section">
													<label for="stripe" class="single-payment-section stripe text-center mb-30" onclick="select_payment('stripe')">
														<img class="img-fluid" src="{{ theme_asset('khana/public/img/stripe.png') }}" alt="">
													</label>
													<input type="radio" name="payment_method" value="stripe" id="stripe" class="d-none">
												</div>

												<div class="col-sm-4 payment_section">
													<label for="swish" class="single-payment-section text-center swish" onclick="select_payment('swish')">
														<img class="img-fluid cod" src="{{ theme_asset('khana/public/img/swish.png') }}" alt="">
													</label>
													<input id="swish" type="radio" class="d-none" name="payment_method" value="swish">
												</div>

												<div class="col-sm-4 payment_section">
													<label for="klarna" class="single-payment-section text-center klarna" onclick="select_payment('klarna')">
														<img class="img-fluid cod" src="{{ theme_asset('khana/public/img/klarna.png') }}" alt="">
													</label>
													<input id="klarna" type="radio" class="d-none" name="payment_method" value="klarna">
												</div>

												{{--<div class="col-lg-3 payment_section">--}}
													{{--<label for="paypal" class="single-payment-section text-center klarna" onclick="select_payment('paypal')">--}}
														{{--<img class="img-fluid cod" src="{{ theme_asset('khana/public/img/paypal.png') }}" alt="">--}}
													{{--</label>--}}
													{{--<input id="paypal" type="radio" class="d-none" name="payment_method" value="paypal">--}}
												{{--</div>--}}
											</div>
										</div>
									</div>

									<input type="hidden" name="total_amount" id="total_amount" value="{{ number_format(str_replace(',', '', Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->total()),2) }}">

									<div class="col-lg-12">
										<div class="form-group">
											<div class="place-order mt-20">
												<button type="submit" id="btnOrder" class="btn btn-primary">{{ __('Place Order') }}</button>
												<button type="button" id="btnOrderLoading" class="btn btn-primary" disabled style="display: none"><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing Order...</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="col-lg-4">
					<div id="checkout_right">
						<div class="checkout-right-section">
							<div class="order-store text-center">
								<h4>{{ __('Your Order') }} {{ Session::get('restaurant_id')['name'] }}</h4>
							</div>
							<div class="order-product-list">
								@foreach(Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->content() as $cart)
								<div class="single-order-product-info d-flex">
									<div class="product-qty-name">
										<span class="product-qty">{{ $cart->qty }}</span> <span class="symbol">x</span><span>{{ $cart->name }}</span>
									</div>
									<div class="product-price-info">
										<span>{{ $currency->value }}: {{ number_format($cart->price,2) }}</span>
									</div>
								</div>
								@endforeach
							</div>
							<div class="product-another-info-show">
								<div class="single-product-another-info-show d-flex">
									<span class="product-another">{{ __('Subtotal') }}</span>
									<span class="product-price">{{ $currency->value }}: {{ Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->priceTotal() }}</span>
								</div>
								@if(Session::has('coupon'))
								<div class="single-product-another-info-show d-flex">
									<span class="product-another">{{ __('Discount') }}</span>
									<span class="product-price">{{ Session::get('coupon')['percent'] }}%</span>
								</div>
								@endif
								<div class="single-product-another-info-show d-flex">
									<span class="product-another">{{ __('Delivery fee') }}</span>
									<span class="product-price">{{ $currency->value }}: <span id="delivery_fee"></span></span>
								</div>
								<div class="single-product-another-info-show d-flex">
									<span class="product-another">{{ __('Tax fee') }}</span>
									<span class="product-price">{{ $currency->value }}: {{ Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->tax() }}</span>
								</div>
								<div class="single-product-another-info-show total d-flex">
									<span class="product-another">{{ __('Total(Incl. VAT)') }}</span>
									<span class="product-price">{{ $currency->value }}: <span id="last_total">{{ Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->total() }}</span></span>
								</div>
							</div>
						</div>
						@if(!Session::has('coupon'))
						<div class="checkout-right-section mt-35">
							<form action="{{ route('coupon') }}" method="POST" id="couponform">
								@csrf
								<div class="apply-coupon">
									<div class="form-group">
										<label>{{ __('Enter Coupon Code') }}</label>
										<div class="d-flex">
											<input class="form-control" type="text" name="code">
											{{--<button type="submit" id="btnApply" class="btn btn-primary">{{__('Apply')}}</button>--}}
											<button type="submit" class="btn btn-primary">{{__('Apply')}}</button>
											{{--<button type="button" id="btnApplyLoading" class="btn btn-primary" style="display: none;"><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>Processing Apply...</button>--}}
										</div>
									</div>
								</div>
							</form>
						</div>
						@endif
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- checkout area end -->

<input type="hidden" id="stripe_api_key" value="{{ env('STRIPE_KEY') }}" />
<input type="hidden" id="currency_value" value="{{ $currency->value }}" />

<input type="hidden" id="price_product" value="{{ Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->priceTotal() }}" />
<input type="hidden" id="price_tax" value="{{ Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->tax() }}" />

@endsection
@push('js')
 <script>
     $.ajaxSetup({
         headers: {
             'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
         }
     });

	//coupon form submit
	 $('#couponform').on('submit',function(e){
		e.preventDefault();

		$.ajax({
		type: 'POST',
		url: this.action,
		data: new FormData(this),
		dataType: 'json',
		contentType: false,
		cache: false,
		processData:false,

		success: function(response){
			if(response.message)
			{
				var alert_message_obj = $('.alert-message-area');
				$('#checkout_right').load(' #checkout_right');
				alert_message_obj.fadeIn();
				$('.ale').html(response.message);
				alert_message_obj.delay( 2000 ).fadeOut( 2000 );
				window.location.reload();
			}

			if(response.error)
			{
				var error_message_obj = $('.error-message-area');
				error_message_obj.fadeIn();
				$('.error-msg').html(response.error);
				error_message_obj.delay( 2000 ).fadeOut( 2000 );
			}

		},
		error: function(xhr, status, error)
		{
			$('.errorarea').show();
			$.each(xhr.responseJSON.errors, function (key, item)
			{
				Sweet('error',item);
				$("#errors").html("<li class='text-danger'>"+item+"</li>")
			});
			errosresponse(xhr, status, error);
		}
	})
	 });

$("body").on("contextmenu",function(e){
return false;
});
$(document).keydown(function(e){
if (e.ctrlKey && (e.keyCode === 67 || e.keyCode === 86 || e.keyCode === 85 || e.keyCode === 117)){
return false;
}
if(e.which === 123){
return false;
}
if(e.metaKey){
return false;
}
//document.onkeydown = function(e) {
// "I" key
if (e.ctrlKey && e.shiftKey && e.keyCode == 73) {
return false;
}
// "J" key
if (e.ctrlKey && e.shiftKey && e.keyCode == 74) {
return false;
}
// "S" key + macOS
if (e.keyCode == 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
return false;
}
if (e.keyCode == 224 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
return false;
}
// "U" key
if (e.ctrlKey && e.keyCode == 85) {
return false;
}
// "F12" key
if (event.keyCode == 123) {
return false;
}
});
</script> 

@if($ordertype == 1)

<script async defer src="https://maps.googleapis.com/maps/api/js?key={{ config('custom.PLACE_KEY') }}&libraries=places&callback=initialize"></script>
<script>

    var circles = [];
    var circlesInfo = [];
    var paymentType = false;

	"use strict";

	var locs = null;
	if (localStorage.getItem('location') != null) {
		locs= localStorage.getItem('location');
	}
	else{
		locs = "{{ $json->full_address }}";
	}

	$('#location_input').val(locs);

	var lati = 0;
	if (localStorage.getItem('lat') !== null) {
		lati=localStorage.getItem('lat');
		$('#latitude').val(lati)
	}	
	else{
		lati= "{{ $resturent_info->resturentlocation->latitude }}";
	}

	var longlat = 0;
	if (localStorage.getItem('long') !== null) {
		longlat=localStorage.getItem('long');
		$('#longitude').val(longlat)
	}
	else{
		longlat= "{{ $resturent_info->resturentlocation->longitude }}";

	}

	var resturentlocation="{{ $json->full_address }}";
	var feePerkilo= "{{ $km_rate->value }}";
	var mapOptions;
	var map;
	var marker;
	var searchBox;
	var city;

	function select_payment(type)
	{
		$('#payment_type').val(type);
		paymentType = true;
	}

    var btnOrder = document.getElementById('btnOrder');
    var btnOrderLoading = document.getElementById('btnOrderLoading');

    btnOrder.addEventListener('click', function(event) {
		//btnOrder.style.display = "none";
		//btnOrderLoading.style.display = "block";
    });

    // var btnApply = document.getElementById('btnApply');
    // var btnApplyLoading = document.getElementById('btnApplyLoading');
	//
    // btnApply.addEventListener('click', function(event) {
    //     btnApply.style.display = "none";
    //     btnApplyLoading.style.display = "block";
    // });
</script>
<script>

	var pointedCircle = null;
    var antennasCircle = null ,
		newMarker = null ,
		setLatitude = 0 ,
    	setLongitude = 0 ,
    	setRadius = 0 ,
		alertWindow = null ,
		title = "",
		currencyValue = $("#currency_value").val(),
        orderOption = $("#order-option").val();

    "use strict";
    function initialize() {

        var infoWindow = '',
            addressEl = document.querySelector('#location_input'),
            latEl = document.querySelector( '#latitude' ),
            longEl = document.querySelector( '#longitude' ),
            element = document.getElementById( 'map-canvas' );

        pointedCircle = null;

        city = document.querySelector( '#city' );

        mapOptions = {
            // How far the maps zooms in.
            zoom: 12,

            // Current Lat and Long position of the pin/
            center: new google.maps.LatLng( lati, longlat),

			scaleControl: true,
            disableDefaultUI: false, // Disables the controls like zoom control on the map if set to true
            scrollWheel: true, // If set to false disables the scrolling on the map.
            draggable: true, // If set to false , you cannot move the map around.
            // mapTypeId: google.maps.MapTypeId.HYBRID, // If set to HYBRID its between sat and ROADMAP, Can be set to SATELLITE as well.
            maxZoom: 21, // Wont allow you to zoom more than this

        };

        alertWindow = new google.maps.InfoWindow();

        /**
         * Creates the map using google function google.maps.Map() by passing the id of canvas and
         * mapOptions object that we just created above as its parameters.
         *
         */
        // Create an object map with the constructor function Map()
        map = new google.maps.Map( element, mapOptions ); // Till this like of code it loads up the map.

        /**
         * Creates the marker on the map
         *
         */
        marker = new google.maps.Marker({
            position: mapOptions.center,
            map: map,
            draggable: true
        });

        /**
         * Creates a search box
         */
        searchBox = new google.maps.places.SearchBox( addressEl );

        /**
         * When the place is changed on search box, it takes the marker to the searched location.
         */
        google.maps.event.addListener( searchBox, 'places_changed', function () {

            var places = searchBox.getPlaces(),
                bounds = new google.maps.LatLngBounds(),
                i, place, lat, long, resultArray,
                addresss = places[0].formatted_address;

            for( i = 0; place = places[i]; i++ ) {

                bounds.extend( place.geometry.location );
                marker.setPosition( place.geometry.location );  // Set marker position new.
            }

            map.fitBounds( bounds );  // Fit to the bound

            map.setZoom( 9 ); // This function sets the zoom to 9, meaning zooms to level 9.


            lat = marker.getPosition().lat();
            long = marker.getPosition().lng();

            latEl.value = lat;
            longEl.value = long;

            localStorage.setItem('lat',lat);
            localStorage.setItem('long',long);
            localStorage.setItem('location',$('#location_input').val());

            pointedCircle = checkPosition(marker.getPosition());

            console.log("search circle number", pointedCircle);

            if(pointedCircle == null && orderOption == 1)
			{
                $("#stateMessage").removeClass("none");
			}
            else {
                $("#stateMessage").addClass("none");
			}

            // Closes the previous info window if it already exists
            if ( infoWindow ) {
                infoWindow.close();
            }

            /**
             * Creates the info Window at the top of the marker
             */
            infoWindow = new google.maps.InfoWindow({
                content: addresss
            });

            infoWindow.open( map, marker );

            // calculatearea();
			calculateDeliveryFee(pointedCircle);

        } );

        /**
         * Finds the new position of the marker when the marker is dragged.
         */
        google.maps.event.addListener( marker, "dragend", function ( event ) {
            var lat, long, address, resultArray, citi;


            lat = marker.getPosition().lat();
            long = marker.getPosition().lng();

            var geocoder = new google.maps.Geocoder();

            geocoder.geocode( { latLng: marker.getPosition() }, function ( result, status ) {
                if ( 'OK' === status ) {
                    address = result[0].formatted_address;
                    resultArray =  result[0].address_components;

                    // Get the city and set the city input value to the one selected
                    for( var i = 0; i < resultArray.length; i++ ) {
                        if ( resultArray[ i ].types[0] && 'administrative_area_level_2' === resultArray[ i ].types[0] ) {
                            citi = resultArray[ i ].long_name;

                        }
                    }
                    addressEl.value = address;
                    latEl.value = lat;
                    longEl.value = long;

                    localStorage.setItem('lat',lat);
                    localStorage.setItem('long',long);
                    localStorage.setItem('location',address);

                } else {
                    alert( 'Geocode was not successful for the following reason: ' + status );
                }

                // Closes the previous info window if it already exists
                if ( infoWindow ) {
                    infoWindow.close();
                }

                /**
                 * Creates the info Window at the top of the marker
                 */
                infoWindow = new google.maps.InfoWindow({
                    content: address
                });

                infoWindow.open( map, marker );

                // calculatearea()

				calculateDeliveryFee(pointedCircle);

            } );

        });

		@foreach($deliveryLocations as $location)
        	drawCircle('{{$location->latitude}}', '{{$location->longitude}}', '{{$location->radius}}', '{{$location->streetName}}', '{{$location->fee}}', '{{$location->minMoney}}');
		@endforeach

		//calculate delivery fee according to the distance
        // calculatearea();

		calculateDeliveryFee(pointedCircle);

        $('#location_input').on('focusout',() => {

            //calculate delivery fee according to the distance
            // calculatearea();
            calculateDeliveryFee(pointedCircle);
        });

        // var origin, destination;

        // function calculatearea() {
		//
        //     var origin = $('#location_input').val();
        //     var destination = resturentlocation;
        //     var travel_mode = "DRIVING";
        //     var directionsDisplay = new google.maps.DirectionsRenderer({'draggable': false});
        //     var directionsService = new google.maps.DirectionsService();
		//
        //     // displayRoute(travel_mode, origin, destination, directionsService, directionsDisplay);
        //     // calculateDistance(travel_mode, origin, destination);
        // }

        // function displayRoute(travel_mode, origin, destination, directionsService, directionsDisplay) {
		//
        //     directionsService.route({
        //         origin: origin,
        //         destination: destination,
        //         travelMode: travel_mode,
        //         avoidTolls: true
        //     }, function (response, status) {
        //         if (status === 'OK') {
		//
        //             directionsDisplay.setDirections(response);
        //         } else {
        //             directionsDisplay.setMap(null);
        //             directionsDisplay.setDirections(null);
        //             $('#msg').show();
        //             var msg=$('#msg').html();
        //             //alert(msg);
        //         }
        //     });
        // }
		//
        // // calculate distance , after finish send result to callback function
        // function calculateDistance(travel_mode, origin, destination) {
		//
        //     var DistanceMatrixService = new google.maps.DistanceMatrixService();
		//
        //     DistanceMatrixService.getDistanceMatrix(
        //         {
        //             origins: [origin],
        //             destinations: [destination],
        //             travelMode: google.maps.TravelMode[travel_mode],
        //             unitSystem: google.maps.UnitSystem.IMPERIAL,
        //             avoidHighways: false,
        //             avoidTolls: false
        //         }, save_results);
        // }
		//
        // // save distance results
        // function save_results(response, status) {
		//
        //     if (status != google.maps.DistanceMatrixStatus.OK) {
        //         $('#result').html(err);
        //     } else {
        //         var origin = response.originAddresses[0];
        //         var destination = response.destinationAddresses[0];
        //         if (response.rows[0].elements[0].status === "ZERO_RESULTS") {
        //             $('#result').html("Sorry , not available to use this travel mode between " + origin + " and " + destination);
        //         } else {
		//
        //             var distance = response.rows[0].elements[0].distance;
        //             var duration = response.rows[0].elements[0].duration;
        //             var distance_in_kilo = distance.value / 1000; // the kilo meter
        //             var distance_in_mile = distance.value / 1609.34; // the mile
        //             var duration_text = duration.text;
		//
		//
        //             var totalfee=feePerkilo*distance_in_kilo;
		//
        //             var amount=$('#total_amount').val();
        //             var amount=amount.replace(/,/g, "");
        //             var total_amount = parseFloat(amount);
		//
        //             //alert(total_amount)
        //             $('#delivery_fee').html(parseFloat(Math.round(totalfee)));
        //             $('#shipping').val(parseFloat(Math.round(totalfee)));
        //             $('#total_price').val(parseFloat(Math.round(total_amount + totalfee)));
        //             $('#last_total').html(parseFloat(Math.round(total_amount + totalfee)));
		//
        //         }
        //     }
        // }
    }

    //draw the circle polygon
    function drawCircle(lat, lng, radius, streetName, fee, minMoney) {

        setLatitude = parseFloat(lat);
        setLongitude = parseFloat(lng);
        setRadius = parseFloat(radius);
        title = streetName + " | Delivery fee is " + fee + currencyValue + " | Minimum Payment is " + minMoney + currencyValue;

        antennasCircle = new google.maps.Circle({
            strokeColor: "#008B8B",
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: "#7FFFD4",
            fillOpacity: 0.45,
            map: map,
            center: {
                lat: setLatitude,
                lng: setLongitude
            },
            radius: setRadius * 1000,
        });

        circles.push(antennasCircle);

        var circleInfo = [fee, minMoney];

        circlesInfo.push(circleInfo);

        map.fitBounds(antennasCircle.getBounds());

        newMarker = new google.maps.Marker({
            position: new google.maps.LatLng(setLatitude, setLongitude),
            map: map,
            title: title,
            draggable: false
        });

        google.maps.event.addListener(newMarker, 'click', (function(newMarker) {
            return function() {
                alertWindow.setContent(title);
                alertWindow.open(map, newMarker);
            }
        })(newMarker));
    }

	//check the pointed position that is contains in polygon
	function checkPosition(point) {

        var center = null;
        var radius = null;
        var i = 0;

		for(i=0;i<circles.length;i++) {

		    center = circles[i].getCenter();
		    radius = circles[i].getRadius();

			if( google.maps.geometry.spherical.computeDistanceBetween(point, center) < radius ) {
			    return i;
			}
		}

		return null;
	}

	function calculateDeliveryFee(circleNumber) {

        var priceProductObj = $("#price_product");
        var priceTaxObj = $("#price_tax");
        var lastValue = 0;

        if(circleNumber == null || orderOption == 0) {

            $('#delivery_fee').html("0");
            lastValue = parseFloat(priceProductObj.val()) + parseFloat(priceTaxObj.val());
			setDeliveryFee(0);
		}
        else {

			var circleInfor = circlesInfo[circleNumber];

            $('#delivery_fee').html(circleInfor[0]);

            setDeliveryFee(circleInfor[0]);
            lastValue = parseFloat(priceProductObj.val()) + parseFloat(circleInfor[0]) + parseFloat(priceTaxObj.val());
            // Didn't check minMoney circleInfor[1]
		}
        $("#total_amount").val(lastValue);
        $("#last_total").html(lastValue);
	}

	function setDeliveryFee(feeVal) {
        $.post("{{ url('add-delivery-fee') }}",
            {
                deliveryFee: feeVal
            },
            function(data, status){

            });
	}

	//payment form action
    $("#form_payment").on('submit', function (e) {

        // if(paymentType == false)
		// {
		//     e.preventDefault();
		// }

		console.log("orderOption", orderOption);
		console.log("pointedCircle", pointedCircle);

		if(orderOption == 1 && pointedCircle == null)
		{
            e.preventDefault();
		}

    });
</script>
@endif

@endpush

