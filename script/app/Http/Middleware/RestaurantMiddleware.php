<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class RestaurantMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $data['state'] = false;
        $data['message'] = "";

        if (Auth::check() && Auth::User()->role_id == 3) {
            if(Auth::User()->status == 'approved'){
                return $next($request);
            }

            $data['message'] = "Please login";
            return $data;

        }else{
            $data['message'] = "Your role ID is not restaurant. Pls check your account.";
            return $data;
        }
    }
}
