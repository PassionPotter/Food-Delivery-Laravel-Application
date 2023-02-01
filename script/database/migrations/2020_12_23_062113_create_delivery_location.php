<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDeliveryLocation extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('delivery_locations', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('restaurantId');
            $table->string('streetName');
            $table->double('longitude')->nullable();
            $table->double('latitude')->nullable();
            $table->double('radius')->nullable();
            $table->double('fee', 15, 2)->nullable();
            $table->double('minMoney', 15, 2)->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('delivery_location');
    }
}
