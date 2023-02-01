<?php

namespace App\Http\Controllers\Api\Restaurant;

use App\Deliverylocation;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Http\Request;
use Auth;
use Illuminate\Support\Facades\Validator;

class DeliveryLocationController extends Controller
{
    public function index()
    {
        $data['state'] = true;
        $data['message'] = "success";

        try {
            $auth = Auth::user();
            $id = $auth->id;
            $data['info'] = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);
            $data['delivery_locations'] = Deliverylocation::where("restaurantId", $id)->paginate(config('custom.DEFAULT_PAGINATE'));
        } catch (\Exception $e)
        {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function create()
    {
        $data['state'] = true;
        $data['message'] = "success";

        try {
            $auth = Auth::user();
            $id = $auth->id;
            $data['info'] = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);
        } catch (\Exception $e)
        {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function store(Request $request)
    {

        $data['message'] = "Add delivery location area successfully";
        $data['state'] = true;

        try {
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
                $data['state'] = false;
                $data['message'] = $validator->errors();

                return $data;
            }

            Deliverylocation::create($inputData);
        } catch (\Exception $e)
        {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function show($deliveryId)
    {
        $data['state'] = true;
        $data['message'] = "success";

        try {

            $auth = Auth::user();
            $id = $auth->id;
            $data['info'] = User::with('resturentlocationwithcity','usersaas','info','Onesignal','delivery','pickup')->find($id);
            $data['delivery_location'] = Deliverylocation::find($deliveryId);

        } catch (\Exception $e) {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }
        return $data;
    }

    public function update(Request $request)
    {
        $data['message'] = 'Updated successfully';
        $data['state'] = true;

        try {
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
                $data['message'] = $validator->errors();
                $data['state'] = false;

                return $data;
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

        } catch (\Exception $e) {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function destroy(Request $request)
    {
        $data['state'] = true;
        $data['message'] = "Delete delivery location successfully";

        try {
            $deliverylocation = Deliverylocation::find($request->locationId);

            if(!$deliverylocation) {
                $data['state'] = false;
                $data['message'] = "Cannot find location as location id is ".$request->locationId;
            }
            else {
                $deliverylocation->delete();
            }

        } catch (\Exception $e) {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }
        return $data;
    }
}
