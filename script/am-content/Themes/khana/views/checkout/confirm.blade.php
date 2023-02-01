@extends('theme::layouts.app')

@section('content')
<div class="confirm-area">
	<div class="container">
		<div class="row mt-50">
			<div class="col-sm-8 offset-sm-2">

				<div class="confirmation-page text-center none" id="order-accepted">
					<i class="fas fa-check-circle none" id="confirmed"></i>
					<i class="fas fa-exclamation-circle none" id="cancelled"></i>

					<div class="order-confirm">
						<h4 id="result"></h4>
						<a href="{{ route('author.dashboard') }}">{{ __('View Order') }}</a>
					</div>
				</div>

				<div class="confirmation-page text-center" id="not-accepted">
					<div class="order-confirm">
						<img class="img-fluid cod" src="{{ theme_asset('khana/public/img/waiting.gif') }}" alt="waiting">
						<h4> {{__('Waiting for confirmation from restaurant.')}}</h4>
						<a href="{{ route('author.dashboard') }}">{{ __('View Order') }}</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection

@section('custom_js')

	<script>

		var confirmOrderId = '{{$confirmOrderId}}';
        var timer = setInterval(checkConfirmed, 3500);

		function checkConfirmed()
		{
            $.get("{{url('/orderCheck')}}/"+confirmOrderId, function(data, status){

                var obj_result = JSON.parse(data);

                if(obj_result['state']) {

                    closeTimer();

				    var response_message = "Your order is confirmed successfully";

				    if(obj_result['status'] == "cancelled") {
					    response_message = "Your order is cancelled";
                        $("#cancelled").removeClass("none");
					}
				    else {
                        $("#confirmed").removeClass("none");
					}

				    $("#result").html(response_message);

				    $("#order-accepted").removeClass("none");
				    $("#not-accepted").addClass("none");
				}
            });
		}

        function closeTimer() {
            clearInterval(timer);
        }

	</script>

@endsection