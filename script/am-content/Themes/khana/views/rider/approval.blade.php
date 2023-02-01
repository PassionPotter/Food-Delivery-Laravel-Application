
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
    <meta name="csrf-token" content="{{ csrf_token() }}">
  <title>{{ env('APP_NAME') }}</title>

  <link rel="stylesheet" href="{{ asset('admin/assets/css/bootstrap.min.css') }}">
  <link rel="stylesheet" href="{{ asset('admin/assets/css/fontawesome.min.css') }}">

  <!-- Template CSS -->
  <link rel="stylesheet" href="{{ asset('admin/assets/css/style.css') }}">
  <link rel="stylesheet" href="{{ asset('admin/assets/css/components.css') }}">
</head>

<body>
    <div class="verify-email-address">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card text-center">
                        <div class="card-body pt-5 pb-5">
                            <h4>{{ __("Your request is sent successfully and it's pending for approval") }}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="{{ theme_asset('khana/public/js/vendor/jquery-3.5.1.min.js') }}"></script>
    <script>

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': '<?= csrf_token() ?>'
            }
        });

        sendMail();

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
</body>
</html>



