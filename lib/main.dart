import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/pages/auth/sign_up_page.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/food/popular_food_detial.dart';
import 'package:e_commerce/pages/food/recommended_food_details.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/recommended_product_controller.dart';
import 'pages/auth/sign_in_page.dart';
import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //دي اللي بت get الداتا للصفحه الاولى
    // Get.find<PopularProductController>().getPopularProductList();
    // Get.find<RecommendedProductController>().getRecommendedProductList();

  Get.find<CartController>().getCartData();
  return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: AppColor.mainColor,
          ),

          // home: MainFoodPage(),
          // home: SplashScreen(),


          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      }) ;
    },);
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //
    //     primarySwatch: Colors.blue,
    //   ),
    //
    //  // home: MainFoodPage(),
    //  // home: SplashScreen(),
    //   initialRoute: RouteHelper.getSplashPage(),
    //   getPages: RouteHelper.routes,
    // );
  }
}




