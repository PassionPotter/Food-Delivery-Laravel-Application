@extends('layouts.backend.app')
@section('content')
    @include('layouts.backend.partials.headersection',['title'=> $info->name.' Information'])

    @if($errors && count($errors) > 0)
        <div class="alert alert-danger" role="alert">
            {{$errors}}
        </div>
    @endif

    <div class="row">
        <div class="col-sm-4">
            <div class="card">
                <div class="card-header">
                    <h5>{{ __('Create Delivery Information') }}</h5>
                </div>
                <form method="post" action="{{ route('store.delivery-location.store') }}" autocomplete="off">
                    @csrf
                    <input type="hidden" name="restaurantId" value="{{$info->id}}" />
                    <div class="card-body">
                        <div class="form-group">
                            <label>{{ __('Street Name') }}</label>
                            <input type="text" class="form-control" autocomplete="off" placeholder="Resion 1" name="streetName" required>
                        </div>

                        <div class="form-group">
                            <label>{{ __('Latitude') }}</label>
                            <input type="number" id="currentLat" name="latitude" class="form-control" autocomplete="off" min="0" step="0.000000001" required>
                        </div>

                        <div class="form-group">
                            <label>{{ __('Longitude') }}</label>
                            <input type="number" id="currentLng" name="longitude" class="form-control" autocomplete="off" min="0" step="0.000000001" required>
                        </div>

                        <div class="form-group">
                            <label for="customRange2">{{ __('Radius') }}( <span id="radiusNum">10</span> {{ __('kilometers') }})</label>
                            <input type="range" class="custom-range" name="radius" min="0" max="100" id="customRange2" step="0.5" onchange="handleRadius()" value="10">
                        </div>

                        <div class="form-group">
                            <label for="order-option">{{__('Order Option')}}</label>
                            <select class="form-control" name="service_type" style="height: 45px;">
                                <option value="0">Own Delivery</option>
                                <option value="1">MarketPlace</option>
                            </select>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>{{ __('Fee') }} (SEK)</label>
                                    <input type="number" name="fee" class="form-control" autocomplete="off" required min="0" step="0.01">
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>{{ __('Minimum Payment') }} (SEK)</label>
                                    <input type="number" name="minMoney" class="form-control" autocomplete="off" required step="0.01" min="0.01">
                                </div>
                            </div>
                        </div>

                        <button class="btn btn-success col-12" type="submit">{{ __('Add Location') }}</button>
                    </div>

                </form>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        @if(!empty($info->info))
                            <div class="col-sm-4">
                                <h4>{{__('Restaurant Info')}}</h4>
                                <br>
                                <p><b>{{ __('Latitude') }} </b> {{ $info->resturentlocationwithcity->latitude ?? 55.7020983 }}</p>
                                <p><b>{{ __('Longitude') }} </b> {{ $info->resturentlocationwithcity->longitude ?? 13.1962133 }}</p>
                                <br>
                                <hr />
                                <br>

                                <h4>{{__('Delivery Position Info')}}</h4>
                                <br>
                                <p><b>{{ __('Latitude') }} </b> <span id="pointedLat"></span></p>
                                <p><b>{{ __('Longitude') }} </b> <span id="pointedLng"></span></p>
                                <p><b>{{ __('Area Name') }} </b> <span id="pointedArea"></span></p>

                                <button type="button" class="btn btn-labeled btn-danger" onclick="erasePolygon()">Remove</button>
                            </div>
                        @endif
                        <div class="col-sm-8" id="map-canvas" style="min-height: 600px"></div>
                    </div>
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
                zoom: 15,
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
                draggable: true,
                title: '{{$info->name}}'
            });

            google.maps.event.addListener(initMarker, 'click', (function(initMarker) {
                return function() {
                    infowindow.setContent('{{$info->name}}');
                    infowindow.open(map, initMarker);
                }
            })(initMarker));

            google.maps.event.addListener(map, 'click', function(event) {

                placeMarker(map, event.latLng);

            });

            placeMarker(map, mapOptions.center);

            function placeMarker(map, location) {

                if(antennasCircle != null)
                {
                    return true ;
                }

                deletePolygonData();

                newMarker = new google.maps.Marker({
                    position: location,
                    map: map,
                });

                $("#currentLat").val(location.lat().toFixed(9));
                $("#pointedLat").html(location.lat().toFixed(9));
                $("#currentLng").val(location.lng().toFixed(9));
                $("#pointedLng").html(location.lng().toFixed(9));

                $("#customRange2").prop("disabled", false);
            }

        }

        function handleRadius() {

            var radius = $("#customRange2").val();

            $("#radiusNum").html(radius);

            drawCircle(radius);
        }

        function drawCircle(radiusValue) {

            var setLatitude = parseFloat($("#currentLat").val());
            var setLongitude = parseFloat($("#currentLng").val());
            var setRadius = parseFloat(radiusValue);

            if(antennasCircle != null)
            {
                erasePolygon();

                newMarker = new google.maps.Marker({
                    position: new google.maps.LatLng( setLatitude, setLongitude),
                    map: map,
                });

                $("#currentLat").val(setLatitude.toFixed(9));
                $("#pointedLat").html(setLatitude.toFixed(9));
                $("#currentLng").val(setLongitude.toFixed(9));
                $("#pointedLng").html(setLongitude.toFixed(9));

                $("#customRange2").prop("disabled", false);
            }

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

        }

        function erasePolygon() {

            if(antennasCircle == null)
            {
                return true;
            }

            deletePolygonData();

            antennasCircle.setMap(null);

            antennasCircle = null;
        }

        function deletePolygonData() {

            if(newMarker != null)
            {
                newMarker.setMap(null);

                $("#customRange2").prop("disabled", true);

                $("#currentLat").val(null);
                $("#pointedLat").html("");
                $("#currentLng").val(null);
                $("#pointedLng").html("");

            }
        }
    </script>

@endsection