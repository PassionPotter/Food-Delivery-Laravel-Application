@extends('theme::layouts.app')

@section('custom_css')

<link rel="stylesheet" href="https://checkoutshopper-test.adyen.com/checkoutshopper/sdk/3.18.2/adyen.css"
      integrity="sha384-5K4T5NNVv7ZBvNypROEUSjvOL45HszUg/eYfYadY82UF4b+hc+TPQ4SsfTGXufJp"
      crossorigin="anonymous">

@endsection

@section('content')

    <div class="text-center">
        <div style="margin-top:100px;">
{{--            {!! \SimpleSoftwareIO\QrCode\Facades\QrCode::size(200)->generate($response) !!}--}}
            <div id="swish-container"></div>
            <br><br>
            <h1>SCAN TO PAY</h1><br>
            <p><b>Don't close this window or tab. You will be redirected when you have finalised the payment in the Swish app</b></p><br>
        </div>
    </div>

    <input type="hidden" id="qrCodeData" value="{{$qrCodeData}}">
    <input type="hidden" id="type" value="{{$type}}">
    <input type="hidden" id="paymentMethodType" value="{{$paymentMethodType}}">
    <input type="hidden" id="paymentData" value="{{$paymentData}}">
    <input type="hidden" id="url" value="{{$url}}">
@endsection

@section('custom_js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="https://checkoutshopper-test.adyen.com/checkoutshopper/sdk/3.18.2/adyen.js"
            integrity="sha384-/5SuEQKK7mLmDWB+eUPAur02KPkNC7pwAqyPez1TuNjeqRjsNDJdAnrbSxrzua2P"
            crossorigin="anonymous"></script>
    <script>

        var action = [];

        action['qrCodeData'] = $("#qrCodeData").val();
        action['type'] = $("#type").val();
        action['paymentMethodType'] = $("#paymentMethodType").val();
        action['paymentData'] = $("#paymentData").val();
        action['url'] = $("#url").val();

        function handleOnChange(state, component) {

            console.log(state.isValid);  // True or false. Specifies if all the information that the shopper provided is valid.
        }

        function handleOnAdditionalDetails(state, component) {

            //if state.valid == true   // successfully
            console.log(state.isValid);
            console.log(state.data);
            //    state.data // Provides the data that you need to pass in the `/payments/details` call.
            if(state.isValid)
            {
                window.location.href("{{url('swish-fallback?paymentData=')}}" + action['paymentData'] + "&redirectResult=" + state.data);
            }
        }

        const configuration = {
            locale: "en_US",
            environment: "test",
            clientKey: "AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#",
            onChange: handleOnChange,
            onAdditionalDetails: handleOnAdditionalDetails
        };

        const checkout = new AdyenCheckout(configuration);

        checkout.createFromAction(action).mount('#swish-container');

    </script>
@endsection