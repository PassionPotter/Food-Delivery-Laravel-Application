@extends('theme::layouts.app')

@push('css')
    <style>
        .StripeElement {
            box-sizing: border-box;

            height: 40px;

            padding: 10px 12px;

            border: 1px solid transparent;
            border-radius: 4px;
            background-color: white;

            box-shadow: 0 1px 3px 0 #e6ebf1;
            -webkit-transition: box-shadow 150ms ease;
            transition: box-shadow 150ms ease;
        }

        .StripeElement--focus {
            box-shadow: 0 1px 3px 0 #cfd7df;
        }

        .StripeElement--invalid {
            border-color: #fa755a;
        }

        .StripeElement--webkit-autofill {
            background-color: #fefde5 !important;
        }
    </style>
    <script>
        var publishable_key = '{{config('custom.STRIPE_TEST_KEY') }}';
    </script>
    <script src="https://js.stripe.com/v3/"></script>
@endpush

@section('content')
    <div class="stripe-payment mt-100 mb-30">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="stripe-payment-form">
                        <form action="{{ route('stripe.charge') }}" method="post" id="payment-form">
                            <div>
                                <label for="card-element">
                                    Credit or debit card
                                </label>
                                <div id="card-element">
                                    <!-- A Stripe Element will be inserted here. -->
                                </div>

                                <!-- Used to display form errors. -->
                                <div id="card-errors" role="alert"></div>
                            </div>

                            <button type="submit" id="btnOrder" class="btn btn-primary">{{ __('Submit Payment') }}</button>
                            <button type="button" id="btnOrderLoading" class="btn btn-primary" disabled style="display: none"><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing Pay...</button>
                            {{ csrf_field() }}
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('js')


    <script type="text/javascript">
        // Create a Stripe client.
        var stripe = Stripe(publishable_key);

        // Create an instance of Elements.
        var elements = stripe.elements();

        // Custom styling can be passed to options when creating an Element.
        // (Note that this demo uses a wider set of styles than the guide below.)
        var style = {
            base: {
                color: '#32325d',
                fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
                fontSmoothing: 'antialiased',
                fontSize: '16px',
                '::placeholder': {
                    color: '#aab7c4'
                }
            },
            invalid: {
                color: '#fa755a',
                iconColor: '#fa755a'
            }
        };

        // Create an instance of the card Element.
        var card = elements.create('card', {style: style});

        // Add an instance of the card Element into the `card-element` <div>.
        card.mount('#card-element');

        // Handle real-time validation errors from the card Element.
        card.addEventListener('change', function(event) {
            var displayError = document.getElementById('card-errors');
            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        });

        var btnOrder = document.getElementById('btnOrder');
        var btnOrderLoading = document.getElementById('btnOrderLoading');

        // Handle form submission.
        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function(event) {

            event.preventDefault();

            //btnOrder.style.display = "none";
            //btnOrderLoading.style.display = "block";

            stripe.createToken(card).then(function(result) {
                console.log("Result:", result);

                if (result.error) {
                    // Inform the user if there was an error.
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                    btnOrder.style.display = "block";
                    btnOrderLoading.style.display = "none";

                } else {

                    // Send the token to your server.
                    stripeTokenHandler(result.token);

                }
            });
        });

        // Submit the form with the token ID.
        function stripeTokenHandler(token) {

            // Insert the token ID into the form so it gets submitted to the server
            var form = document.getElementById('payment-form');
            var hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);

            // Submit the form
            form.submit();
        }
    </script>
@endpush

