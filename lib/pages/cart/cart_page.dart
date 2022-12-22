

import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/pages/home/home_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_icon_bar.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../routes/route_helper.dart';
import '../../utills/app_constance.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(

                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      size: Dimensions.height35,
                      iconSize:Dimensions.height20 ,
                    ),
                    onTap: (){
                    //  Get.toNamed(RouteHelper.initial);
                    },
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>HomePage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      size: Dimensions.height35,
                      iconSize:Dimensions.height20 ,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    size: Dimensions.height35,
                    iconSize:Dimensions.height20 ,
                  ),
                ],
              ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return(cartController.getItems.length>0)? Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top:Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    return ListView.builder(
                      itemCount: cartController.getItems.length,
                      itemBuilder: (_,index){
                        return Container(
                          height: Dimensions.height100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(

                                child: Container(
                                  width: Dimensions.width20*5,
                                  height: Dimensions.height100,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.BASE_URL+'/uploads/'+cartController.getItems[index].img!
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  var popularIndex=Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(cartController.getItems[index].product!);
                                  if(popularIndex>=0)
                                  {
                                    Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                  }
                                  else{
                                    var recommendedIndex=Get.find<RecommendedProductController>()
                                        .recommendedProductList
                                        .indexOf(cartController.getItems[index].product!);
                                    if(recommendedIndex<0)
                                    {
                                      print("presses");
                                      Get.snackbar(
                                        "History Product ",
                                        "Product review is not available for history products ",
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 2),
                                      );
                                    }
                                    else
                                    {
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));

                                    }
                                  }
                                },
                              ),
                              SizedBox(width: Dimensions.width10/2,),
                              Expanded(child: Container(
                                height: Dimensions.height100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: cartController.getItems[index].name!,
                                      color: Colors.black54,
                                    ),
                                    SmallText(text: "text"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "\$ ${cartController.getItems[index].price!*cartController.getItems[index].quantity!}",
                                          color: Colors.redAccent,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(Dimensions.height10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(

                                                child: Icon(
                                                  Icons.remove,
                                                  color: AppColor.signColor,
                                                ),
                                                onTap: (){
                                                  // popularProduct.setQuantity(false);
                                                  cartController.addItem(cartController.getItems[index].product!, -1);
                                                },
                                              ),
                                              SizedBox(width: Dimensions.width10/2,),
                                              BigText(text:cartController.getItems[index].quantity.toString()),
                                              SizedBox(width: Dimensions.width10/2,),
                                              GestureDetector(
                                                onTap: (){
                                                  // popularProduct.setQuantity(true);
                                                  cartController.addItem(cartController.getItems[index].product!, 1);

                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColor.signColor,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        );
                      },
                    );
                  },),
                ),
              ),
            ):NoDataPage(text: "Your Cart is Empty!",);
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            ),
            color:(cartController.getItems.length>0)? AppColor.buttonBackgroundColor:Colors.white,

          ),
          child:(cartController.getItems.length>0)? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: BigText(text: "\$ ${cartController.totalAmount}"),
              ),
              GestureDetector(
                onTap: (){
                 // popularProduct.addItem(product);
                 if(Get.find<AuthController>().userLoggedIn())
                   {
                   //   print("pressed");
                   //  cartController.addToHistory();
                     if(Get.find<LocationController>().addressList.isEmpty)
                       {
                         Get.toNamed(RouteHelper.getAddAddressPage());
                       }
                     else{
                       Get.offNamed(RouteHelper.getPaymentPage("100127",Get.find<UserController>().userModel!.id!));
                      // Get.offNamed(RouteHelper.getInitial(),);
                     }
                   }
                 else{
                   Get.toNamed(RouteHelper.getSignInPage());
                 }

                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColor.mainColor,
                  ),
                  child: BigText(
                    text: "check out",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ):Container(),
        );
      }),
    );
  }
}
