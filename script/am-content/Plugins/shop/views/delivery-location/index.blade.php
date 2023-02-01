@extends('layouts.backend.app')

@section('content')
    @include('layouts.backend.partials.headersection',['title'=> $info->name.' Information'])

    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-5">

                            @foreach($deliveryLocations as $location)
                                <a href="{{ url('store/delivery-location/'.$location->id)}}"><h4>{{ $location->streetName  }}</h4></a>

                                <span><b>{{ __('Service Type') }} : </b> <span> @if($location->service_type == 0) {{__('Own Delivery')}} @else {{__('MarketPlace')}} @endif </span></span> <br/>
                                <span><b>{{ __('Latitude') }} : </b> <span>{{  $location->latitude }}</span></span>
                                <span><b>{{ __('Longitude') }} : </b> <span>{{  $location->longitude }}</span></span>
                                <br>
                                <span><b>{{ __('Fee') }} : </b> <span>{{  $location->fee }}</span> | <b>{{ __('Minimum Payment') }} : </b> <span>{{  $location->minMoney }}</span> </span>
                                <hr>
                            @endforeach

                        </div>
                        <div class="col-sm-7" id="map-canvas" style="min-height: 600px"></div>
                    </div>
                    <div>{!! $deliveryLocations->links() !!}</div>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" value="{{ $info->resturentlocationwithcity->latitude ?? 55.7020983 }}" id="latitude">
    <input type="hidden" value="{{ $info->resturentlocationwithcity->longitude ?? 13.1962133 }}" id="longitude">
@endsection

@section('script')
    <script src="{{ asset('admin/js/form.js') }}"></script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key={{ config('custom.PLACE_KEY') }}&libraries=places&callback=initialize"></script>

    <script>

        var map = null;
        var antennasCircle = null;
        var newMarker = null;
        var setLatitude = 0;
        var setLongitude = 0;
        var setRadius = 0;
        var infowindow = null;

        "use strict";
        function initialize() {

            var mapOptions, initMarker, searchBox, city,

                latEl = document.querySelector( '#latitude' ),
                longEl = document.querySelector( '#longitude' ),
                element = document.getElementById( 'map-canvas' );

            city = document.querySelector( '#city' );

            infowindow = new google.maps.InfoWindow();

            mapOptions = {
                // How far the maps zooms in.
                zoom: 13,
                // Current Lat and Long position of the pin/
                center: new google.maps.LatLng( $('#latitude').val(), $('#longitude').val()),

                scaleControl: true,
                disableDefaultUI: false, // Disables the controls like zoom control on the map if set to true
                scrollWheel: true, // If set to false disables the scrolling on the map.
                draggable: true, // If set to false , you cannot move the map around.
                // mapTypeId: google.maps.MapTypeId.HYBRID, // If set to HYBRID its between sat and ROADMAP, Can be set to SATELLITE as well.
                maxZoom: 21, // Wont allow you to zoom more than this
            };

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

            initMarker = new google.maps.Marker({
                position: mapOptions.center,
                map: map,
                draggable: false,
                title: '{{$info->name}}'
            });

            google.maps.event.addListener(initMarker, 'click', (function(initMarker) {
                return function() {
                    infowindow.setContent('{{$info->name}}');
                    infowindow.open(map, initMarker);
                }
            })(initMarker));

            @foreach($deliveryLocations as $location)
                drawCircle('{{$location->latitude}}', '{{$location->longitude}}', '{{$location->radius}}', '{{$location->streetName}} | Delivery fee is {{$location->fee}} | Minimum Payment is {{$location->minMoney}}');
            @endforeach
        }

        function drawCircle(lat, lng, radius, streetName) {

            setLatitude = parseFloat(lat);
            setLongitude = parseFloat(lng);
            setRadius = parseFloat(radius);

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

            map.fitBounds(antennasCircle.getBounds());

            newMarker = new google.maps.Marker({
                position: new google.maps.LatLng(setLatitude, setLongitude),
                map: map,
                title: streetName,
                draggable: false
            });

            google.maps.event.addListener(newMarker, 'click', (function(newMarker) {
                return function() {
                    infowindow.setContent(streetName);
                    infowindow.open(map, newMarker);
                }
            })(newMarker));
        }
    </script>

@endsection