@section('style')

@endsection
@extends('layouts.backend.app')

@section('content')

<div class="card">
	<div class="card-body">
		<div class="card-action-filter">
			<div class="row mb-10">
				<div class="card-header">
					<div class="col-lg-12">
                        <form id="basicform" method="post" action="{{ route('store.day.update') }}">
                            @csrf
                            <div class="d-flex">
                                <div class="single-filter">
                                    <h4>{{ __('Shop Days') }}</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="offset-10">
                                    <div class="single-filter f-right">
                                        <div class="single-filter">
                                            <input type="submit" class="btn btn-success btn-lg" value="{{ __('Update') }}" />
                                            <input type="button" class="btn btn-primary btn-lg" value="{{ __('Clear All') }}" onclick="clearShopDay()"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2 mb-2">
                                <div class="row">
                                    <div class="col-md-3">
                                        <p class="am-title">{{ __('Day') }}</p>
                                    </div>
                                    <div class="col-md-3">
                                        <p class="am-title">{{ __('Opening Time') }}</p>
                                    </div>
                                    <div class="col-md-3">
                                        <p class="am-title">{{ __('Closeing Time') }}</p>
                                    </div>
                                    <div class="col-md-3">
                                        <p class="am-title">{{ __('Status') }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-2 mb-2">

                                @php
                                    $weekdayArray = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
                                @endphp

                                @if(count($days)==0 || !$days)
                                    @for($i=0;$i<count($weekdayArray);$i++)
                                        <div class="row">
                                            <div class="col-md-3">
                                                <p>{{ $weekdayArray[$i] }}</p>
                                            </div>
                                            <div class="col-md-9 {{ strtolower($weekdayArray[$i]) }}">
                                                <input type="hidden" name="day[]" value="{{ strtolower($weekdayArray[$i]) }}">
                                                <div class="row {{ strtolower($weekdayArray[$i]) }}-0 mb-2">
                                                    <div class="col-md-4">
                                                        <input type="Time" name="opening[]" class="input-group-text" required="">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <input type="Time" name="closeing[]" class="input-group-text" required="">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="input-group">
                                                            <select class="input-group-text" name="status[]">
                                                                <option value="1">{{ __('Open') }}</option>
                                                                <option value="0">{{ __('Close') }}</option>
                                                            </select>
                                                            <span class="input-group-prepend">
                                                                <span class="input-group-text">
                                                                    <i class="fa fa-plus-circle fa-lg" onclick="addNewTime('{{ $i }}', 0)"></i>
                                                                    <i class="fa fa-trash fa-lg none" onclick="delTime('{{ $i }}', 0)"></i>
                                                                </span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr>
                                    @endfor
                                @else
                                    @php $counter = 0; @endphp
                                    @foreach($days as $key => $row)
                                        <div class="row">
                                            <div class="col-md-3">
                                                <p>{{ strtoupper($row[0]->day) }}</p>
                                            </div>
                                            <div class="col-md-9 {{ $key }}">
                                                @for($i=0;$i<count($row);$i++)
                                                    <div class="row {{ $key }}-{{$i}} mb-2">
                                                        <input type="hidden" name="day[]" value="{{ $key }}">
                                                        <div class="col-md-4">
                                                            <input type="Time" name="opening[]" class="input-group-text" value="{{ $row[$i]->opening }}" required="">
                                                        </div>
                                                        <div class="col-md-4">
                                                            <input type="Time" name="closeing[]" class="input-group-text" value="{{ $row[$i]->close }}" required="">
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="input-group">
                                                                <select class="input-group-text" name="status[]">
                                                                    <option value="1" @if($row[$i]->status == 1) selected @endif>{{ __('Open') }}</option>
                                                                    <option value="0" @if($row[$i]->status == 0) selected @endif>{{ __('Close') }}</option>
                                                                </select>
                                                                <span class="input-group-prepend">
                                                                    <span class="input-group-text">
                                                                        <i class="fa fa-plus-circle fa-lg @if($i != (count($row) - 1)) none @endif" onclick="addNewTime('{{ $counter }}', '{{$i}}')"></i>
                                                                        <i class="fa fa-trash fa-lg @if($i == (count($row) - 1)) none @endif" onclick="delTime('{{ $counter }}', '{{$i}}')"></i>
                                                                    </span>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                @endfor
                                            </div>
                                        </div>
                                        <hr>
                                        @php $counter++; @endphp
                                    @endforeach
                                @endif

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>
@endsection

@section('script')
	<script src="{{ asset('admin/js/form.js') }}"></script>
	<script>
        var weekdayArray = ['saturday', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday'];

        function addNewTime(weekId, el_number) {
            var number = parseInt(el_number);
            var nextNumber = number + 1;
			var elementClass = weekdayArray[weekId] + "-" + number;
			var nextElementClass = weekdayArray[weekId] + "-" + nextNumber;
			var parentClass = "." + weekdayArray[weekId];

			$("." + elementClass).find(".fa-plus-circle").addClass("none");
			$("." + elementClass).find(".fa-trash").removeClass("none");

			var addText = '<div class="row ' + nextElementClass + ' mb-2">' +
                '<input type="hidden" name="day[]" value="' + weekdayArray[weekId] + '">' +
                '<div class="col-md-4">' +
                '<input type="Time" name="opening[]" class="input-group-text" required="">' +
                '</div>' +
                '<div class="col-md-4">' +
                '<input type="Time" name="closeing[]" class="input-group-text" required="">' +
                '</div>' +
                '<div class="col-md-4">' +
                '<div class="input-group">' +
                '<select class="input-group-text" name="status[]">' +
                '<option value="1">Open</option>' +
                '<option value="0">Close</option>' +
                '</select>' +
                '<span class="input-group-prepend">' +
                '<span class="input-group-text">' +
                '<i class="fa fa-plus-circle fa-lg" onclick="addNewTime(' + weekId + ', ' + nextNumber + ')"></i>' +
                '<i class="fa fa-trash fa-lg none" onclick="delTime(' + weekId + ', ' + nextNumber + ')"></i>' +
                '</span>' +
                '</span>' +
                '</div>' +
                '</div>' +
                '</div>';

			$(parentClass).append(addText);

		}

		function delTime(weekId, number) {
            var elementClassName = "." + weekdayArray[weekId] + "-" + number;
            $(elementClassName).remove();
		}

        function clearShopDay() {
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            $.post("{{url('store/clear-day')}}",
                function(data, status){
                    if(data['state'] == true)
                    {
                        window.location.href = "{{url('store/my-day')}}";
                    }
                });
        }
	</script>
@endsection