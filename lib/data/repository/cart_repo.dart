import 'dart:convert';

import 'package:e_commerce/utills/app_constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List <String> cart=[];
  //بمررلها الداتا من الفانكشن الموجوده في cart controller
  void addToCartList(List<CartModel>cartList){
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    cart=[];
    //عشان اقدر احول ال cartmodel ال objectالى string
    //convert object to string because sharedPrefreneces
    var time=DateTime.now().toString();
    cartList.forEach((element) {
      element.time=time;//دي عاملها عشان اخلي كل اللي هيضاف في اليست دي يكون عنده نفس الوقت
      return cart.add(jsonEncode(element));
    });
    

    
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  getCartList();
  }

  //دلوقتي اللي هعمله عشان احول من ال encodeالي ال decodeعشان اقدر استخدم الداتا
  List<CartModel>getCartList(){
    List<String>carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts=sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    print("inside in cart list "+carts.toString());
      //هنا عشان اخزن قيم ال stringفي ال carts
    }

    List<CartModel>cartList=[];
    /*
    List<object>list=[
    "object1",
    "object2",
    "object3",
    ]


    */
    carts.forEach((element) {
     return cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel>carListtHistory=[];
    cartHistory.forEach((element) {
     return carListtHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return carListtHistory;
  }

  List<String>cartHistory=[];
  void addToCartHistory(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0;i<cart.length;i++)
      {
        print("history List is ${cart[i]}");
        cartHistory.add(cart[i]);
      }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the lemgth of history list is "+getCartHistoryList().length.toString());
  }
  //to remove from cart and sharedprefrences
  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

  }

}