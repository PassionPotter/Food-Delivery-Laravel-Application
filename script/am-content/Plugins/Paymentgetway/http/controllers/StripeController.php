<?php 

namespace Amcoders\Plugin\Paymentgetway\http\controllers;
use Amcoders\Plugin\Plugin;
use Amcoders\Plugin\SendNotificationMobile;
use Amcoders\Theme\khana\http\controllers\OrderController as OrderControllerRedirect;
use App\Onesignal;
use App\Order;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Cartalyst\Stripe\Laravel\Facades\Stripe;

class StripeController extends controller
{

    public static function make_payment($array)
    {
           try {

               Stripe::setApiKey(config("custom.STRIPE_TEST_SECRET"));

               $charge = Stripe::charges()->create([
                   'amount' => $array['amount'] * 100,
                   'currency' => $array['currency'],
                   'source' => $array['stripeToken'],
                   'description' => ""
               ]);

               if(!$charge)
               {
                   return OrderControllerRedirect::redirect_if_payment_faild("Canceled Payment");
               }

               $data['payment_id'] = $charge['id'];
               $data['redirectResult'] = "";
               $data['paymentData'] = "";
               $data['reference'] = "";
               $data['payment_method'] = "stripe";

               $order_info= Session::get('order_info');

               $data['ref_id'] =$order_info['ref_id'];
               $data['amount'] =$order_info['amount'];
               $data['vendor_id'] =$order_info['vendor_id'];

               return OrderControllerRedirect::redirect_if_payment_success($data);

        } catch (\Exception $e) {
            return OrderControllerRedirect::redirect_if_payment_faild($e->getMessage());
        }

    }

}