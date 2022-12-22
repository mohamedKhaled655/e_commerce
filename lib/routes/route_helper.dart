
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/pages/auth/sign_in_page.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/food/popular_food_detial.dart';
import 'package:e_commerce/pages/food/recommended_food_details.dart';
import 'package:e_commerce/pages/home/home_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/pages/payment/payment_page.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_map.dart';

class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";
  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";
  static const String payment="/payment";
  static const String orderSuccess="/order-successful";


  static String getSplashPage()=>"$splashPage";
  static String getInitial()=>"$initial";
  static String getPopularFood(int pageId,String page)=>"$popularFood?pageId=${pageId}&page=${page}";
  static String getRecommendedFood(int pageId ,String page)=>"$recommendedFood?pageId=${pageId}&page=$page";
  static String getCartPage()=>"$cartPage";
  static String getSignInPage()=>"$signIn";
  static String getAddAddressPage()=>"$addAddress";
  static String getPickAddressPage()=>"$pickAddressMap";
  static String getPaymentPage(String id,int userID)=>"$payment?id=${id}&userID=${userID}";
  static String getOrderSuccessPage()=>"$orderSuccess";


  static List<GetPage>routes=[

    GetPage(name: splashPage, page: ()=>SplashScreen()),

    GetPage(name: initial, page: ()=>HomePage()),
    GetPage(name: signIn, page: ()=>SignInPage(),transition:Transition.fade, ),

    GetPage(name:popularFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      print("p=$pageId");
      return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
      transition:Transition.circularReveal,
    ),
    GetPage(name:recommendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return RecommendedFoodDetails(pageId:int.parse(pageId!) ,page:page!);
    },
      transition:Transition.circularReveal,
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition:Transition.circularReveal,
    ),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    },
      transition:Transition.fade,
    ),
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress= Get.arguments;
      return _pickAddress;
    },
      transition:Transition.fade,
    ),

    GetPage(name: payment, page: (){
      return PaymentPage(
          orderModel: OrderModel(
              id: int.parse(Get.parameters['id']!),
              userId:int.parse(Get.parameters['userID']!),
          ),
      );
    },
      transition:Transition.fade,
    ),
    // GetPage(name: orderSuccess, page: (){
    //   return OrderSuccessPage();
    // },
    //   transition:Transition.fade,
    // ),

  ];
}