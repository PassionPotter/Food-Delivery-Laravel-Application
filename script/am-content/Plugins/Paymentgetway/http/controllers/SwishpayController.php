<?php

namespace Amcoders\Plugin\Paymentgetway\http\controllers;
use Amcoders\Plugin\Plugin;
use Amcoders\Theme\khana\http\controllers\OrderController as OrderControllerRedirect;
use App\Onesignal;
use App\Order;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Amcoders\Plugin\SendNotificationMobile;

class SwishpayController extends controller
{

    public static function make_payment($array)
    {
        try {

            $phone=$array['phone'];
            $email=$array['email'];
            $amount= "".$array['amount']."";
            $ref_id=$array['ref_id'];
            $name=$array['name'];
            $billName=$array['billName'];
            $currency=$array['currency'];
            $address = $array['address'];
            $reference = 'test-' . time();

            $client = new \Adyen\Client();
            $client->setEnvironment(\Adyen\Environment::TEST);
            $client->setHttpProxy("http://172.25.1.2:3129");

            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $client->setTimeout(60);

            $service = new \Adyen\Service\Checkout($client);

            $params = array(
                "amount" => array(
                    "currency" => $currency,
                    "value" => floor($amount) * 100
                ),
                "reference" => $reference,
                "paymentMethod" => array(
                    "type" => "swish"
                ),
                "countryCode" => "SE",
                "merchantAccount" => "Viralconvert158ECOM",
                "shopperLocale" => "en-US",
                "channel" => "Web",
                "returnUrl" => route('swish_fallback'),
            );

            $result = $service->payments($params);

            $qrCodeData = $result['action']['qrCodeData'];
            $type = $result['action']['type'];
            $paymentMethodType = $result['action']['paymentMethodType'];
            $paymentData = $result['action']['paymentData'];
            $url = $result['action']['url'];

            Session::put("paymentData", $paymentData);
            Session::put("reference", $reference);

            return view('theme::checkout.payment.swish-qrcode',compact("type", "qrCodeData", "paymentData", "paymentMethodType", "url"));

        } catch (\Exception $e)
        {
            return OrderControllerRedirect::redirect_if_payment_faild($e->getMessage());
        }

    }

    public function swish_success_payment(Request $request)
    {
        try {

            $paymentData = Session::get("paymentData");
            $reference = Session::get("reference");

            $client = new \Adyen\Client();
            $client->setEnvironment(\Adyen\Environment::TEST);
            $client->setHttpProxy("http://172.25.1.2:3129");

            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $client->setTimeout(60);
            $service = new \Adyen\Service\Checkout($client);

            $details = [
                "redirectResult" => $request->redirectResult
            ];

            $params = [
                'paymentData' => $paymentData,
                'details' => $details
            ];

            $response = $service->paymentsDetails($params);

            if ($response['resultCode'] == "Authorised"){
                $data['payment_id'] = $response["pspReference"];
                $data['redirectResult'] = $request->redirectResult;
                $data['paymentData'] = $paymentData;
                $data['reference'] = $reference;
                $data['payment_method'] = "swish";

                $order_info= Session::get('order_info');
                $data['ref_id'] =$order_info['ref_id'];
                $data['amount'] =$order_info['amount'];
                $data['vendor_id'] =$order_info['vendor_id'];

                return OrderControllerRedirect::redirect_if_payment_success($data);
            }
            else {
                return OrderControllerRedirect::redirect_if_payment_faild("Payment is cancelled");
            }

        } catch (\Exception $e)
        {
            return OrderControllerRedirect::redirect_if_payment_faild($e->getMessage());
        }
    }

}