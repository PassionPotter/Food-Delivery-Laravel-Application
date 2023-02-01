@extends('theme::layouts.app')

@section('content')
<div class="main-content mt-50">
	<div class="container">
		<div class="row">
			<div class="col-lg-10 offset-lg-1">
				<div class="register-card">
					<div class="register-progress text-center">
						<nav>
							<ul>
								<li class="active">
									<div class="register-progress-number">
										<span>1</span>
									</div>
									<div class="register-progress-body">
										{{ __('Step 1') }}
									</div>
								</li>
								<li class="active">
									<div class="register-progress-number">
										<span>2</span>
									</div>
									<div class="register-progress-body">
										{{ __('Step 2') }}
									</div>
								</li>
								<li class="active">
									<div class="register-progress-number">
										<span>3</span>
									</div>
									<div class="register-progress-body">
										{{ __('Step 3') }}
									</div>
								</li>
								<li>
									<div class="register-progress-number">
										<span>4</span>
									</div>
									<div class="register-progress-body">
										{{ __('Step 4') }}
									</div>
								</li>
							</ul>
						</nav>
					</div>

					<form id="send_data" action="{{ route('restaurant.register_step_3') }}" method="POST" enctype="multipart/form-data">
						@csrf
						<div class="register-card-body">
							<div class="row mt-30">
								@if(Session::has('errors'))
								<div class="col-lg-12">
									@php
										$messageErrors = Session::get('errors');
									@endphp
									<p class="alert alert-danger">{{$messageErrors}}</p>
								</div>
								@endif
								<div class="col-lg-12">
									<div class="resturant-profile-cover-img">
										<div class="register-cover-img imgUp">
											<label for="restaurent_cover" class="imagePreview">
												<i class="fas fa-image"></i>
											</label>
											<input type="file" name="cover_img" id="restaurent_cover" class="media-img d-none">
										</div>
										<div class="logo-img imgUp">
											<label for="logo_img" class="imagePreview">
												<i class="fas fa-camera"></i>
											</label>
											<input type="file" name="logo_img" id="logo_img" class="media-img d-none">
										</div>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="f-right">
										<input type="button" onclick="sendMailData()" value="{{ __('Next & Save') }}">
									</div>
								</div>
							</div>
						</div>
					</form>	
				</div>
			</div>
		</div>
	</div>
</div>
@endsection

@section('custom_js')
	<script>

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': '<?= csrf_token() ?>'
            }
        });

        function sendMailData()
        {
            sendMail();
            $("#send_data").submit();
        }

        function sendMail()
        {
            $.post("{{url('email/resend')}}",
                {
                    message: "Message",
                },
                function(data, status){
                    console.log("Data: " + data + "\nStatus: " + status);
                });
        }
	</script>
@endsection