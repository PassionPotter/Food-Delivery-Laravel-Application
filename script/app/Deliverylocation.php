<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Deliverylocation extends Model
{
    protected $table = 'delivery_locations';

    protected $fillable = [
        'streetName', 'longitude', 'latitude', 'radius', 'fee', 'minMoney', 'restaurantId'
    ];
}
