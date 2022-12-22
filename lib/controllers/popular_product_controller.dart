import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({ required this.popularProductRepo});

  List<dynamic>_popularProductList=[];
  List<dynamic>get popularProductList=>_popularProductList;

 late CartController _cart;

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  Future<void>getPopularProductList()async{
    Response response =await popularProductRepo.getPopularProductList();

    if(response.statusCode==200){
      _popularProductList=[];
      _popularProductList.addAll(ProductModel.fromJson(response.body).products);
      print("states code = "+response.statusCode.toString());
      print("get dattttta");
      print(_popularProductList);
      _isLoaded=true;
      update();
    }
    else{
      print("states code = "+response.statusCode.toString());
      print("Dont get dattttta");
      Get.snackbar(
        "Check ",
        "Make sure you are connected to the internet",
        backgroundColor: AppColor.mainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  }

  int quantity=0;
  int _inCartItems=0;
  int get inCartItem=>_inCartItems+quantity;
  void setQuantity(bool increament){
    if(increament==true)
      {
        if(_inCartItems+quantity>=20)
        {
          quantity=20;
          Get.snackbar(
            "Item Count =$quantity",
            "You Can't add more !",
            backgroundColor: AppColor.mainColor,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }else
          {quantity=quantity+1;}

        print("incr=$quantity");
      }
    else{
      if(_inCartItems+quantity<=0)
        {
          if(_inCartItems>=0)
            {
              quantity=-_inCartItems;

            }
          // quantity=0;
          Get.snackbar(
            "Item Count =$quantity",
            "You Can't reduce more !",
            backgroundColor: AppColor.mainColor,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        }
      else{quantity=quantity-1;}

      print("incr=$quantity");
    }
    update();
  }

  void initProduct( ProductData product,CartController cart){
    quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    //print("exist or not ${exist}");
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    //print("the qu in the cart is = ${_inCartItems}");
  }

  void addItem(ProductData product) {
    // if(quantity>0)
      {
        _cart.addItem(product, quantity);
        quantity=0;
        _inCartItems=_cart.getQuantity(product);

        _cart.items.forEach((key, value) {
          print("the id is ${value.id}"+"  the quantit = ${value.quantity }");
        });
      }
    // else{
    //   Get.snackbar(
    //     "Item Count ",
    //     "You should at least add an item in the cart !",
    //     backgroundColor: AppColor.mainColor,
    //     colorText: Colors.white,
    //     duration: Duration(seconds: 2),
    //   );
    // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;

  }

  List<CartModel>get getItems{
    print(_cart.getItems);
    return _cart.getItems;
  }


}