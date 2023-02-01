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

class KlarnapayController extends controller
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

            $reference = 'tes-' . time();
            $client = new \Adyen\Client();

            $client->setEnvironment(\Adyen\Environment::TEST);
            $client->setHttpProxy("http://172.25.1.2:3129");
            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $client->setTimeout(60);
            $service = new \Adyen\Service\Checkout($client);


            $params = [

                "merchantAccount" => "Viralconvert158ECOM",
                "reference" => 'test-' . time(),
                "paymentMethod" => [
                    "type" => "klarna"
                ],
                "amount" => [
                    "currency" => $currency,
                    "value" => floor($amount) * 100,
                ],
                "shopperLocale" => "en_US",
                "countryCode" => "SE",
                "telephoneNumber" => $phone,
                "shopperEmail" => $email,
                "shopperName" => [
                    "firstName" => $name,
                    "gender" => "UNKNOWN",
                    "lastName" => "Approved"
                ],
                "shopperReference" => $reference,
                "billingAddress" => [
                    "city" => "Ankeborg",
                    "country" => "SE",
                    "houseNumberOrName" => "1",
                    "postalCode" => "12345",
                    "street" => "Stargatan"
                ],
                "deliveryAddress" => [
                    "city" => "Ankeborg",
                    "country" => "SE",
                    "houseNumberOrName" => "1",
                    "postalCode" => "12345",
                    "street" => "Stargatan"
                ],

                "returnUrl" => route('klarna_fallback'),

                "lineItems" => [
                    [
                        "quantity" => "1",
                        "amountExcludingTax" => "331",
                        "taxPercentage" => "2100",
                        "description" => "Shoes",
                        "id" => "Item #1",
                        "taxAmount" => "69",
                        "amountIncludingTax" => "0",
                        "productUrl" => "https://ibb.co/NNfXPJ8",
                        "imageUrl" =>"https://ibb.co/NNfXPJ8",
                    ],
                ],
            ];

            $result = $service->payments($params);

            $returnUrl = $result['action']['url'];

            Session::put("paymentData", $result['paymentData']);
            Session::put("reference", $reference);

            return redirect()->to($returnUrl);

        } catch (\Exception $e)
        {
            return OrderControllerRedirect::redirect_if_payment_faild($e->getMessage());
        }

    }

    public function klarna_success_payment(Request $request)
    {
        try {

            if(!Session::has('paymentData')) {
                return OrderControllerRedirect::redirect_if_payment_faild("Don't select order");
            }

            $client = new \Adyen\Client();

            $paymentData = Session::get("paymentData");
            $reference = Session::get("reference");

            $details = [
                "redirectResult" => $request->redirectResult
            ];

            $client->setEnvironment(\Adyen\Environment::TEST);

            $client->setHttpProxy("http://172.25.1.2:3129");
            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $client->setTimeout(60);
            $service = new \Adyen\Service\Checkout($client);

            $params = [
                'paymentData' => $paymentData,
                'details' => $details
            ];

            //There is error in here
            $response = $service->paymentsDetails($params);

            $resultCode = $response["resultCode"];

            if($resultCode == "Authorised") {

                $data['payment_id'] = $response["pspReference"];
                $data['redirectResult'] = $request->redirectResult;
                $data['paymentData'] = $paymentData;
                $data['reference'] = $reference;
                $data['payment_method'] = "klarna";

                $order_info= Session::get('order_info');
                $data['ref_id'] =$order_info['ref_id'];
                $data['amount'] =$order_info['amount'];
                $data['vendor_id'] =$order_info['vendor_id'];

                return OrderControllerRedirect::redirect_if_payment_success($data);

            }
            else {
                return OrderControllerRedirect::redirect_if_payment_faild("Payment is canceled");
            }

        } catch (\Exception $e)
        {
            return OrderControllerRedirect::redirect_if_payment_faild($e->getMessage());
        }
    }

}