<?php

namespace Amcoders\Plugin\Paymentgetway\http\controllers\subscription;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use Omnipay\Omnipay;
use Session;

class KlarnapayController extends controller
{

    public static function redirect_if_payment_success()
    {
        return route('store.payment.success');
    }

    public static function redirect_if_payment_faild()
    {
        return route('store.payment.fail');
    }

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

            $client = new \Adyen\Client();
            $client->setEnvironment(\Adyen\Environment::TEST);

            $client->setHttpProxy("http://172.25.1.2:3129");
            $client->setXApiKey("AQExhmfxLYPIaBVFw0m/n3Q5qf3VfoJfDJ9JV2tAw2q/zzMTsonBQcpC5wDTKunmT699NRDBXVsNvuR83LVYjEgiTGAH-18O45fkVHrwm+JVz2uSEHwv/6rMj+U72lFdTqyzI0bM=-&Ief73%:4ev%,S2#");
            $service = new \Adyen\Service\Checkout($client);

            $params = [
                "merchantAccount" => "Viralconvert158ECOM",
                "reference" => 'test-' . time(),
                "paymentMethod" => [
                    "type" => "klarna"
                ],
                "amount" => [
                    "currency" => $currency,
                    "value" => "200"
                ],
                "shopperLocale" => "en_US",
                "countryCode" => "SE",
                "telephoneNumber" => "+46 840 839 298",
                "shopperEmail" => $email,
                "shopperName" => [
                    "firstName" => "Testperson-se",
                    "gender" => "UNKNOWN",
                    "lastName" => "Approved"
                ],
                "shopperReference" => 'tes-' . time(),

                "returnUrl" => route('store.klarna_fallback'),
                "cancelUrl" => KlarnapayController::redirect_if_payment_faild(),
            ];

            $result = $service->payments($params);

            $returnUrl = $result['action']['url'];

            return redirect()->to($returnUrl);

        } catch (\Exception $e)
        {
            return KlarnapayController::redirect_if_payment_faild();
        }

    }

    public function klarna_success_payment(Request $request)
    {
        return $request->all();
    }


}