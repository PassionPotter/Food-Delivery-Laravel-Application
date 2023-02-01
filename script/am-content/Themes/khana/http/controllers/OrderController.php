<?php 

namespace Amcoders\Theme\khana\http\controllers;

use Amcoders\Plugin\SendNotificationMobile;
use App\Onesignal;
use App\User;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;

use App\Order;
use App\Ordermeta;

use Amcoders\Plugin\Plugin;
use Carbon\Carbon;
use Amcoders\Plugin\Paymentgetway\http\controllers\PaypalController;
use Amcoders\Plugin\Paymentgetway\http\controllers\StripeController;
use Amcoders\Plugin\Paymentgetway\http\controllers\ToyyibpayController;
use Amcoders\Plugin\Paymentgetway\http\controllers\InstamojoController;
use Amcoders\Plugin\Paymentgetway\http\controllers\RazorpayController;
use Amcoders\Plugin\Paymentgetway\http\controllers\KlarnapayController;
use Amcoders\Plugin\Paymentgetway\http\controllers\SwishpayController;

class OrderController extends controller
{
    public function store(Request $request)
    {
        try {

            if(!Session::has('restaurant_id') && Session::has('restaurant_cart'))
            {
                $data=Session::get('order_info');
                Order::destroy($data['ref_id']);
                return redirect()->route('author.dashboard')->with('error', 'Order Failed!');
            }

            $restaurantId = Session::get('restaurant_id')['id'];
            $restaurant = User::find($restaurantId);

            if($restaurant->status != "approved") {
                $message = "Sorry. " . $restaurant->name . " is closed right now. Please try after a few minutes";

                return redirect()->route('author.dashboard')->with('error', $message);
            }

            $replace_total = str_replace(',', '', Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->subtotal());

            $tax = Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->tax();

            $request->validate([
                'name' => 'required|max:255',
                'phone' => 'required|numeric',
                'delivery_address' => 'required',
                'payment_method' => 'required',
            ]);

            $deliveryFee = 0;

            if(Session::has('deliveryFee'))
            {
                $deliveryFee = Session::get('deliveryFee');
                Session::forget('deliveryFee');
            }

            $replace_total = $replace_total + $deliveryFee + $tax;

            $shipping = 0;

            if (isset($request->shipping) && $request->shipping != null) {
                $shipping=  str_replace(",","",number_format($request->shipping,2));
            }

            $order = new Order();

            $order->user_id = Auth::id();
            $order->vendor_id = $restaurantId;
            $order->payment_method = $request->payment_method;
            $order->payment_status = 0;
            $order->delivery_fee = $deliveryFee;

            if (Session::has('coupon')) {
                $order->coupon_id = Session::get('coupon')['id'];
            }

            $order->order_type = 1;

//            if(Session::has('delivery_type'))
//            {
//                $order->order_type = Session::get('delivery_type')['type'];
//            }else{
//                $order->order_type = 1;
//            }


            $order->total = $replace_total;

            if (!empty($request->shipping)) {
                $order->shipping = $shipping;
            }

            $order->discount = Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->discount();

            $data['name']=$request->name;
            $data['phone']=$request->phone;
            $data['address']=$request->delivery_address;
            $data['latitude']=$request->latitude;
            $data['longitude']=$request->longitude;
            $data['note']=$request->order_note;
            $data['payment_id'] = null;
            $data['redirectResult'] = null;
            $data['paymentData'] = null;
            $data['reference'] = null;

            $order->data = json_encode($data);

            $order->save();

            foreach (Cart::instance('cart_'.Session::get('restaurant_cart')['slug'])->content() as $key => $row) {

                $ordermeta = new Ordermeta;
                $ordermeta->order_id = $order->id;
                $ordermeta->term_id  = $row->id;
                $ordermeta->qty  = $row->qty;
                $ordermeta->total  = $row->price;
                $ordermeta->save();
            }

            if ($request->payment_method=='cod') {
                if (Plugin::is_active('WebNotification')) {
                    $vendors=\App\Onesignal::where('user_id',Session::get('restaurant_id')['id'])->latest()->take(2)->get();
                    foreach ($vendors as $key => $row) {
                        OneSignal::sendNotificationToUser("New Order",$row->player_id,url('/store/order/'.$order->id));
                    }
                }
            }

            else{

                $data['amount']=$replace_total + $shipping;

                $data['currency']=currency_name();

                $currency = currency_name();

                $total = $replace_total + $shipping;

                $data['ref_id']=$order->id;
                $data['vendor_id']=$order->vendor_id;
                $data['amount']= str_replace(",","",number_format($total,2));
                $data['email']=Auth::user()->email;
                $data['name']=Auth::user()->name;
                $data['phone']=$request->phone;
                $data['billName']="payment for order";
                $data['currency']=$currency;
                Session::put('order_info',$data);

            }

            Session::forget('restaurant_id');
            Session::forget('cart_'.Session::get('restaurant_cart')['slug']);
            Session::forget('cart');
            Session::forget('coupon');
            Session::forget('delivery_type');

            if ($request->payment_method=='paypal') {
                try {
                    return PaypalController::make_payment($data);
                } catch (\Exception $e) {
                    $order->delete();
                    if(Session::has('orderId'))
                    {
                        Session::forget('orderId');
                    }
                    return redirect()->route('author.dashboard')->with('error', $e->getMessage());
                }
            }

            if($request->payment_method == 'swish') {
                try {
                    return SwishpayController::make_payment($data);
                } catch (\Exception $e) {
                    $order->delete();
                    if(Session::has('orderId'))
                    {
                        Session::forget('orderId');
                    }
                    return redirect()->route('author.dashboard')->with('error', $e->getMessage());
                }
            }

            if($request->payment_method == 'klarna')
            {
                try {
                    return KlarnapayController::make_payment($data);

                } catch (\Exception $e)
                {
                    $order->delete();

                    if(Session::has('orderId'))
                    {
                        Session::forget('orderId');
                    }
                    return redirect()->route('author.dashboard')->with('error', $e->getMessage());
                }
            }

            if ($request->payment_method=='stripe') {
                return redirect('payment-with/stripe');
            }

            if ($request->payment_method=='toyyibpay') {
                return ToyyibpayController::make_payment($data);
            }

            if ($request->payment_method=='razorpay') {
                return redirect('payment-with/razorpay');
            }

            if ($request->payment_method=='instamojo') {
                try {
                    return InstamojoController::make_payment($data);
                } catch (\Throwable $th) {
                    $order->delete();
                    if(Session::has('orderId'))
                    {
                        Session::forget('orderId');
                    }
                    return redirect()->route('author.dashboard')->with('error', 'Transaction Failed');
                }
            }
            return redirect('order/confirmation');

        } catch (\Exception $e)
        {
            return redirect()->route('author.dashboard')->with('error', $e->getMessage());
        }

    }

    public function stripe_view()
    {
      return view('theme::checkout.payment.stripe');
    }

    public function razorpay_view()
    {
        if(Session::has('order_info'))
        {
            $data=Session::get('order_info');
            try {

                $response=RazorpayController::make_payment($data);
                return view('theme::checkout.payment.razorpay',compact('response'));
            } catch (\Throwable $th) {
                Order::destroy($data['ref_id']);
                return redirect()->route('author.dashboard')->with('error', 'Transaction Failed');
            }
        }
    }

    public function stripe(Request $request)
    {
        if (Session::has('order_info')) {
           $data=Session::get('order_info');
           $data['stripeToken']=$request->stripeToken;
          return StripeController::make_payment($data);
        }
       
    }

    public function payment_success()
    {

        if (Session::has('payment_info')) {

            $payment_info = Session::get('payment_info');
            $order_id=$payment_info['ref_id'];
            $order=Order::find($order_id);
            $info=json_decode($order->data);
            $info->payment_id=$payment_info['payment_id'];
            $order->data=json_encode($info);
            $order->payment_status=1;
            $order->save();

            Session::forget('payment_info');
            Session::forget('order_info');

            if (Plugin::is_active('WebNotification')) {
                $vendors=\App\Onesignal::where('user_id',$order->vendor_id)->latest()->take(2)->get();
                foreach ($vendors as $key => $row) {
                    OneSignal::sendNotificationToUser("New Order",$row->player_id,url('/store/order/'.$order->id));
                }
            }

            return redirect('order/confirmation');
        }
        Session::forget('payment_info');
        Session::forget('order_info');

        abort(404);
        
    }

    public function payment_fail(Request $request)
    {

        if (Session::has('payment_info')) {
            $payment_info= Session::get('payment_info');
            $order_id=$payment_info['ref_id'];
            Order::destroy($order_id);
            Session::forget('payment_info');
        }

        if (Session::has('order_info')) {
            $data= Session::get('order_info');
            $order_id=$data['ref_id'];
            Order::destroy($order_id);
            Session::forget('order_info');
        }

        return redirect()->route('author.dashboard')->with('error', 'Transaction Failed');
        
    }


    public static function redirect_if_payment_success($payment_info = null)
    {
        if($payment_info == null)
        {
            Session::forget('order_info');
            abort(404);
        }
        else {

            Session::forget('order_info');
            $order_id = $payment_info['ref_id'];
            $order = Order::find($order_id);
            $info = json_decode($order->data);
            $info->payment_id=$payment_info['payment_id'];
            $info->redirectResult = $payment_info['redirectResult'];
            $info->paymentData = $payment_info['paymentData'];
            $info->reference = $payment_info['reference'];
            $order->data=json_encode($info);
            $order->payment_status=1;
            $order->save();

            if (Plugin::is_active('WebNotification')) {
                $vendors=\App\Onesignal::where('user_id',$order->vendor_id)->latest()->take(2)->get();
                foreach ($vendors as $key => $row) {
                    OneSignal::sendNotificationToUser("New Order",$row->player_id,url('/store/order/'.$order->id));
                }
            }

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

                $name = Auth::user()->name;
                $message = $name . " ordered food right now on computer. ";
                SendNotificationMobile::sendPushNotification($message, $fcm_token, "Order");
            }

            Session::put("confirmOrderId", $order_id);

            return redirect('order/confirmation');
        }

    }

    public static function redirect_if_payment_faild($message = null)
    {
        if (Session::has('order_info')) {
            $data= Session::get('order_info');
            $order_id=$data['ref_id'];
            Order::destroy($order_id);
            Session::forget('order_info');
        }

        return redirect()->route('author.dashboard')->with('error', $message);
    }

    public function order_check($id)
    {
        $data['state'] = false;
        $data['message'] = "Server Error";
        $data['status'] = "error";

        try {

            $order = Order::find($id);

            if($order->status == 3) {
                $data['state'] = true;
                $data['status'] = "confirmed";
            }

            if($order->status == 0) {
                $data['state'] = true;
                $data['status'] = "cancelled";
            }

            $data['message'] = "success";
        } catch (\Exception $e) {
            $data['state'] = false;
            $data['message'] = $e->getMessage();
        }

        return json_encode($data);
    }
}