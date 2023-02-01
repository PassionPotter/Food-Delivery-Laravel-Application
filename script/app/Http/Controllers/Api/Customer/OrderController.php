<?php

namespace App\Http\Controllers\Api\Customer;

use Amcoders\Plugin\SendNotificationMobile;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Hash;
use Auth;
use Cart;
use Session;
use App\Order;
use App\Ordermeta;



class OrderController extends Controller
{
	public function index()
	{
		$orders = Order::where('user_id',Auth::User()->id)->orderBy('id','DESC')->get();
		return $orders;
	}

	public function details($id)
	{
		$info=Order::where('user_id',Auth::id())->with('orderlist','vendorinfo','riderinfo','coupon','orderlog','riderlog','liveorder')->find($id);
		return $info;
	}

	public function store(Request $request)
	{

	    $restaurant = User::find($request->vendor_id);

        if($restaurant->status != "approved") {
            $res['order'] = null;
            $res['state'] = false;
            $res['message'] = "Sorry. " . $restaurant->name . " is closed right now. Please try after a few minutes";
            return $res;
        }

        $auth = Auth::user();
		 $order = new Order();
		 $order->user_id = $auth->id;
		 $order->vendor_id = $request->vendor_id;
		 $order->delivery_fee = $request->delivery_fee;
		 $order->seen = 0;
		 $order->order_type = 1;
		 $order->payment_method = $request->payment_method;
		 $order->payment_status = $request->payment_status;
		 if($request->coupon_id)
		 {
		 	$order->coupon_id = $request->coupon_id;
		 }
		 $order->total = $request->total;
		 $order->shipping = $request->shipping;
		 $order->commission = $request->commission;
		 $order->discount = $request->discount;
		 $order->status = $request->status;
		 $data['name']=$request->name;
         $data['phone']=$request->phone;
         $data['address']=$request->delivery_address;
         $data['latitude']=$request->latitude;
         $data['longitude']=$request->longitude;
         $data['note']=$request->order_note;
         $data['payment_id']=null;
         $order->data = json_encode($data);
         $order->save();

     	foreach($request->datacart as $key => $value) {
         	$ordermeta = new Ordermeta;
            $ordermeta->order_id = $order->id;
            $ordermeta->qty  = $value['quantity'];
            $ordermeta->total  = $value['price'];
            $ordermeta->term_id  = $value['food']['id'];
            $ordermeta->save();
        }

     	$res['order'] = $order;
     	$res['message'] = "Order is created";
     	$res['state'] = true ;

        //function that send notification to users
        $restaurant = User::find($order->vendor_id);

        $isOnline = SendNotificationMobile::isOnline($restaurant->id);

        if($isOnline)
        {
            $fcm_token = null;

            if(isset($restaurant->fcm_token))
            {
                $fcm_token = $restaurant->fcm_token;
            }

            $name = $auth->name;
            $message = $name . " ordered food right now on phone.";
            SendNotificationMobile::sendPushNotification($message, $fcm_token, "Order");
        }

     	return $res;
	}

    public function order_check($id)
    {
        $data['state'] = true;
        $data['message'] = "pending";

        try {

            $order = Order::find($id);

            if($order->status == 3) {
                $data['message'] = "confirmed";
            }

            if($order->status == 0) {
                $data['message'] = "cancelled";
            }

        } catch (\Exception $e) {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }
}

