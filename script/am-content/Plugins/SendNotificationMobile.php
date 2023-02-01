<?php


namespace Amcoders\Plugin;


use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class SendNotificationMobile
{

    public static function sendPushNotification($message, $fcm_token, $title)
    {
        define('API_ACCESS_KEY', 'AAAAvXocJnU:APA91bEYYaiccPQ_9n1-EgcIlgrh-2QCn5I04FKjuQZUFElYQLY9-09gZTAodff_7Ld-QVMpb3JG1ToQNP893vFh0fDWXhhY_ieabtQ4v0UBOb00AdYyqj7XwykhhuJf3sI2RbcIuTBv');

        $fcmNotification = [
            'to' => $fcm_token, //user auth token
            'notification' => [
                "body" => $message,
                "title" => $title,
            ],
        ];

        $headers = [
            'Authorization: key=' . API_ACCESS_KEY,
            'Content-Type: application/json'
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
        $result = curl_exec($ch);
        curl_close($ch);

    }

    public static function isOnline($id)
    {
        return Cache::has('user-is-online-' . $id);
    }
}