<?php

namespace Amcoders\Plugin\shop\http\controllers;

use App\Deliverylocation;
use App\Http\Controllers\Controller;
use App\Order;
use App\Riderlog;
use App\Transactions;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use mysql_xdevapi\Exception;

class DeliveryLocationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $auth = Auth::user();

        $id = $auth->id;

        $info = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);

        $deliveryLocations = Deliverylocation::where("restaurantId", $id)->paginate(config('custom.DEFAULT_PAGINATE'));

        if ($info->role_id==3) {

            return view('plugin::delivery-location.index',compact('info', 'deliveryLocations'));
        }
        else {
            return redirect()->back();
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $auth = Auth::user();

        $id = $auth->id;

        $info = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);

        if ($info->role_id==3) {

            return view('plugin::delivery-location.create',compact('info'));
        }
        else {
            return redirect()->back();
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $inputData = $request->all();

        //Validate requested data
        $validator = Validator::make($inputData, [
            'restaurantId' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'radius' => 'required',
            'fee' => 'required',
            'minMoney' => 'required',
            'streetName' => 'required',
            'service_type' => 'required'
        ]);

        if($validator->fails()){
            $errors = $validator->errors();
            return redirect()->back()->with('errors', $errors);
        }

        Deliverylocation::create($inputData);

        return redirect('store/delivery-location');

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Deliverylocation  $deliverylocation
     * @return \Illuminate\Http\Response
     */
    public function show($deliveryId)
    {
        $auth = Auth::user();

        $id = $auth->id;

        $info = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);

        $deliveryLocation = Deliverylocation::find($deliveryId);

        if ($info->role_id==3) {

            return view('plugin::delivery-location.edit',compact('info', 'deliveryLocation'));
        }
        else {
            return redirect()->back();
        }

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Deliverylocation  $deliverylocation
     * @return \Illuminate\Http\Response
     */
    public function edit(Deliverylocation $deliverylocation)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Deliverylocation  $deliverylocation
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $locationId = $request->locationId;

        $inputData = $request->all();

        //Validate requested data
        $validator = Validator::make($inputData, [
            'locationId' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'radius' => 'required',
            'fee' => 'required',
            'minMoney' => 'required',
            'streetName' => 'required',
            'service_type' => 'required'
        ]);

        if($validator->fails()){
            $errors = $validator->errors();
            return redirect()->back()->with('errors', $errors);
        }

        $deliveryLocation = Deliverylocation::find($locationId);

        $deliveryLocation->latitude = $inputData['latitude'];
        $deliveryLocation->longitude = $inputData['longitude'];
        $deliveryLocation->fee = $inputData['fee'];
        $deliveryLocation->radius = $inputData['radius'];
        $deliveryLocation->minMoney = $inputData['minMoney'];
        $deliveryLocation->streetName = $inputData['streetName'];
        $deliveryLocation->service_type = $inputData['service_type'];
        $deliveryLocation->save();

        return redirect('store/delivery-location');


    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Deliverylocation  $deliverylocation
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {

        $deliverylocation = Deliverylocation::find($request->locationId);

        $deliverylocation->delete();
        return redirect('store/delivery-location');
    }
}
