<?php


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('404',function(){
	return abort(404);
})->name(404);


// // sitemap route
Route::get('/sitemap.xml', 'SettingController@sitemapView');

Route::get('locale','LocalizationController@store')->name('language.set'); 
// laravel auth routes
Auth::routes(['verify' => true]);

Route::get('/mysettings','Admin\UserController@index')->name('admin.admin.mysettings')->middleware('auth');
Route::post('genup','Admin\UserController@genUpdate')->name('admin.users.genupdate')->middleware('auth');
Route::post('passup','Admin\UserController@updatePassword')->name('admin.users.passup')->middleware('auth');




/*
|--------------------------------------------------------------------------
| Admin Routes
|--------------------------------------------------------------------------
|
| All Admin routes are here
|
|
*/

//Admin settings route
Route::group(['as' =>'admin.','prefix'=>'admin','namespace'=>'Admin','middleware'=>['auth','admin']],function(){


	//roles
	Route::resource('role', 'RoleController');
	Route::post('roles/destroy', 'RoleController@destroy')->name('roles.destroy');
	//users
	Route::resource('users', 'AdminController');
	Route::post('/userss/destroy', 'AdminController@destroy')->name('users.destroy');


	//dashboard route
	Route::get('dashboard','DashboardController@dashboard')->name('dashboard');
	Route::post('announcement','DashboardController@announcement')->name('announcement');
	// page resource route
	Route::resource('page','PageController');
	Route::post('pages/destroy','PageController@destroy')->name('page.destroy');

	// blog resource route
	Route::resource('blog/post','PostController');
	Route::post('post/destroy','PostController@destroy')->name('post.destroys');
	Route::resource('blog/comment','CommentController');
	Route::get('/comment/disqus','CommentController@apiview')->name('dsiqus.settings');

	Route::post('blog/comments/destroy','CommentController@destroy')->name('comments.destroy');
	Route::get('blog/comments/reply/{id}','CommentController@reply')->name('comment.reply');
	Route::resource('blog/category','CategoryController');

	Route::post('disqus','CommentController@disqus')->name('disqus.store');

	// category route
	Route::post('categorys','CategoryController@destroy')->name('categorys.destroy');
	Route::resource('settings','SettingsController');
	// menu route
	Route::resource('appearance/menu','MenuController');
	Route::post('menues/destroy','MenuController@destroy')->name('menues.destroy');
	Route::post('menues/node','MenuController@MenuNodeStore')->name('menus.MenuNodeStore');
	//theme route 
	Route::get('appearance/theme','ThemeController@index')->name('theme.index');
	Route::get('theme/{name}','ThemeController@active')->name('theme.active');
	Route::post('theme/upload','ThemeController@upload')->name('theme.upload');
	//widget route 
	Route::get('appearance/widget','WidgetController@index')->name('widget.index');
	//themeoptions route
	Route::get('appearance/themeoptions','ThemeoptionsController@index')->name('themeoptions.index');
	//script route
	Route::resource('appearance/script','ScriptController');
	//Plugin route
	Route::get('plugin','PluginController@index')->name('plugin.index');
	Route::get('plugin/active/{plugin}','PluginController@active')->name('plugin.active');
	Route::get('plugin/deactive/{plugin}','PluginController@deactive')->name('plugin.deactive');
	Route::post('plugin/upload','PluginController@upload')->name('plugin.upload');

	//seo route
	Route::resource('setting/seo','SeoController');

	//env route
	Route::resource('setting/env','EnvController');
	Route::resource('setting/filesystem','FilesystemController');

	//performance route
	Route::resource('setting/performance','PerfomaceController');


	//general route
	Route::resource('setting/general','GensettingsController');


	//permission route
	Route::get('permission','PermissionController@index')->name('permission.index');


	//usersystem route
	Route::get('usersystem','UsersystemController@index')->name('usersystem.index');


	//information route
	Route::get('information','InformationController@index')->name('information.index');

	//permissions
	Route::resource('permission','PermissionController');

	//langauge route
	Route::get('language','LanguageController@index')->name('language.index');
    Route::get('language/create','LanguageController@create')->name('language.create');
    Route::post('lang/store','LanguageController@store')->name('lang.store');
    Route::post('lang/set','LanguageController@set')->name('lang.set');
    Route::get('lang/{lang_code}/delete/{theme_name}','LanguageController@delete')->name('lang.delete');
    Route::get('lang/{lang_code}/edit/{theme_name}','LanguageController@edit')->name('lang.edit');
    Route::post('lang/{lang_code}/update/{theme_name}','LanguageController@update')->name('lang.update');


	//Customizer All Route
	Route::get('customizer','CustomizerController@index')->name('customizer.index');
	Route::get('customizer/page_change','CustomizerController@page_change')->name('customizer.page_change');
	Route::get('customizer/section_option','CustomizerController@section_option')->name('customizer.section_option');
	Route::get('customizer/value_update','CustomizerController@value_update')->name('customizer.value_update');
	Route::get('customizer/multiple_settings_option','CustomizerController@multiple_settings_option')->name('customizer.multiple_settings_option');
	Route::post('customizer/image_upload','CustomizerController@image_upload')->name('customizer.image_upload');
	Route::get('customizer/save','CustomizerController@save')->name('customizer.save');

});


/*
|--------------------------------------------------------------------------
| Store Routes
|--------------------------------------------------------------------------
|
| All Store routes are here
|
|
*/
Route::group(['as' =>'store.','prefix'=>'store','namespace'=>'Store','middleware'=>['auth','store','verified','approval']],function(){
	// dashboard route
	Route::get('dashboard','DashboardController@dashboard')->name('dashboard');
	Route::post('status','DashboardController@status')->name('status');
});


Route::group(['as' =>'admin.','prefix'=>'admin','namespace'=>'Admin','middleware'=>['auth']],function(){
	// dashboard route
	Route::get('dashboard','DashboardController@dashboard')->name('dashboard');
	Route::resource('media','MediaController');
	Route::get('medias/json','MediaController@json')->name('medias.json');
	Route::get('media/info/{id}','MediaController@show');
	Route::post('medias/remove','MediaController@destroy')->name('medias.destroy');
	
});

// Social Login Route
Route::get('login/{provider}', 'Auth\LoginController@redirectToProvider');
Route::get('login/{provider}/callback', 'Auth\LoginController@handleProviderCallback');