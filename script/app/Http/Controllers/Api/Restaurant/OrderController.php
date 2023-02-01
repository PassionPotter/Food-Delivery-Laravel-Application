<?php

namespace App\Http\Controllers\Api\Restaurant;

use App\Http\Controllers\Controller;
use App\Location;
use App\Order;
use App\Orderlog;
use App\Riderlog;
use App\Terms;
use App\User;
use Illuminate\Http\Request;
use Auth;

class OrderController extends Controller
{
    public function show($id)
    {
        $data['message'] = "success";
        $data['state'] = true;

        try {
            $auth_id=Auth::id();

            $data['info'] = Order::with('orderlist','vendorinfo','riderinfo','coupon','orderlog','riderlog')->where('vendor_id',$auth_id)->find($id);

            if (empty($data['info']->rider_id)) {
                $riders = Location::where('role_id',4)
                    ->where('term_id',$data['info']->vendorinfo->location->term_id)
                    ->whereHas('riders')
                    ->with('riders')
                    ->inRandomOrder()
                    ->take(20)
                    ->get();
            }
            $data['riders'] = $riders ?? [];
        } catch (\Exception $e)
        {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function update(Request $request)
    {
        $data['message'] = 'Order is pending';
        $data['state'] = true;

        try {
            $validatedData = $request->validate([
                'status' => 'required',
                'orderId' => 'required'
            ]);
            $id = $request->orderId;
            $auth_id=Auth::id();
            $order=Order::where('vendor_id',$auth_id)->find($id);

            if($order->order_type==1 && $request->status != 0){
                $validatedData = $request->validate([
                    'rider' => 'required',
                ]);
            }
            if ($request->rider && $request->status != 0) {
                $order->rider_id=$request->rider;
            }

            $order->status=$request->status;
            $order->fulfillment_time = $request->fulfillmentTime;
            $order->save();

            if($order->order_type==1 && $request->status != 0){
                $validatedData = $request->validate([
                    'rider' => 'required',
                ]);

                $riderlog = new Riderlog;
                $riderlog->order_id = $order->id;
                $riderlog->user_id = $request->rider;
                $riderlog->status = 2;
                $riderlog->save();

//            if (Plugin::is_active('WebNotification')) {
//                $rider=\App\Onesignal::where('user_id',$request->rider)->latest()->first();
//                if (!empty($rider)) {
//                    OneSignal::sendNotificationToUser("New Order",$rider->player_id,url('/rider/order/'.$order->id));
//                }
//            }

            }

            $log = new Orderlog;
            $log->order_id = $order->id;
            $log->status = $request->status;
            $log->save();

            if ($request->status == 1) {
                $sum = Order::where('vendor_id',$auth_id)->where('status',1)->sum('total');
                $sellerbadges=Terms::where('type',3)->where('status',1)->where('slug', '>=', $sum)->orderBy('slug','ASC')->first();
                if (!empty($sellerbadges)) {
                    $seller = User::find($auth_id);
                    $seller->badge_id = $sellerbadges->id;
                    $seller->save();
                }

                $commsion=User::with('usersaas')->find(Auth::id());


                $or=Order::where('vendor_id',$auth_id)->find($id);
                if ($commsion->usersaas->commission != 0) {

                    $com1=$commsion->usersaas->commission/100;
                    $net_commision=$com1*$or->total;
                    $or->commission=$net_commision;

                }
                else{
                    $or->commission = 0;
                }
                $or->save();

            }

            $data['state'] = $request->status;

            if ($request->status == 3) {
                $data['message'] = 'Order Processed';
            }

            if($request->status == 1){
                $data['message'] = 'Order Completed';
            }

            if($request->status == 0){

                if($order->payment_method == "stripe") {
                    $resp = $this->strip_refund($order);
                }

                if($order->payment_method == "klarna" || $order->payment_method == "swish") {
                    $resp = $this->adyen_refund($order);
                }

                $data['message'] = $resp;

            }
        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
            $data['state'] = 4;
        }

        return $data;
    }

    public function strip_refund($order){

        $info = json_decode($order->data);
        $res = "Not Authorised";

        try {

            if($info->payment_id) {

                $stripe = new \Stripe\StripeClient(
                    config("custom.STRIPE_TEST_SECRET")
                );

                $refund = $stripe->refunds->create([
                    'charge' => $info->payment_id,
                ]);

                $res = "Order Cancelled";
            }

        } catch (\Exception $e) {
            $res = $e->getMessage();
        }

        return $res;
    }

    public function adyen_refund($order) {

        try {

            $info = json_decode($order->data);
            $res = "Not Authorised";

            if(!$info->payment_id) {
                return $res;
            }

            if(!$info->redirectResult) {
                return $res;
            }

            if(!$info->paymentData) {
                return $res;
            }

            $client = new \Adyen\Client();

            $client->setEnvironment(\Adyen\Environment::TEST);
            $client->setHttpProxy("http://172.25.1.2:3129");
            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $client->setTimeout(60);
            $checkService = new \Adyen\Service\Checkout($client);

            $details = [
                "redirectResult" => $info->redirectResult
            ];

            $checkParams = [
                'paymentData' => $info->paymentData,
                'details' => $details
            ];

            $state = $checkService->paymentsDetails($checkParams);
            $client->setUsername("admin");
            $client->setPassword("Roligt55%");
            $client->setApplicationName("eatonline");
            $service = new \Adyen\Service\Modification($client);
            $response = null;

            if($state["resultCode"] == "Authorised") {

//                $modificationAmount = array(
//                    "value" => $order->total,
//                    "currency"=> "SEK"
//                );

                $params = array(
//                    "modificationAmount" => $modificationAmount,
                    "merchantAccount" => "Viralconvert158ECOM",
                    "originalReference" => $info->payment_id,
                    "reference" => "test-". time()
                );

                $response = $service->cancelOrRefund($params);

                if($response["pspReference"]) {
                    $res = "Order cancelled";
                }
                else {
                    $res = "Server error";
                }
            }
            else {
                $res = "Unauthorized this order payment data.";
            }

        } catch (\Exception $e)
        {
            $res = $e->getMessage();
        }

        return $res;

    }
}
