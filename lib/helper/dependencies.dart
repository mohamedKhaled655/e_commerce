import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/data/repository/auth_repo.dart';
import 'package:e_commerce/data/repository/cart_repo.dart';
import 'package:e_commerce/data/repository/location_repo.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/data/repository/user_repo.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recomended_product_repo.dart';

Future<void>init()async{
  final sharedPreferences=await SharedPreferences.getInstance();

  // sharedPreferences
  Get.lazyPut(() => sharedPreferences);


  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL,sharedPreferences:Get.find() ));
  
  
  ////repo
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=>UserRepo(apiClient: Get.find(), ));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));


  /// controllers
  Get.lazyPut(() => AuthController(authRepo:Get.find() ));
  Get.lazyPut(() => UserController(userRepo:Get.find() ));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
}