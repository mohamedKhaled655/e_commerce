

import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/exandable_text_widget.dart';
import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utills/app_constance.dart';
import '../../utills/colors.dart';
import '../../widgets/app_colum.dart';
import '../../widgets/app_icon_bar.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail  extends StatelessWidget {
  int pageId;
  String page;
   PopularFoodDetail ({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];

    print("page id is "+pageId.toString());
    print("product is "+product.name.toString());

    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height350,

                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL+'/uploads/'+product.img!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ),
          Positioned(
            top: 45,
            left: 30,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    //Get.to(MainFoodPage());
                 if(page=="cartpage")
                   {
                     Get.toNamed(RouteHelper.getCartPage());
                   }
                 else{
                   Get.toNamed(RouteHelper.getInitial());
                 }
                  },
                  child: Center(
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                ),

                GetBuilder<PopularProductController>(builder:(controller) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        GestureDetector(

                          child: AppIcon(
                            icon: Icons.add_shopping_cart,
                          ),
                          onTap: (){
                            if(controller.totalItems>=1)
                             Get.toNamed(RouteHelper.getCartPage());
                          },
                        ),
                        controller.totalItems>=1?Positioned(
                          top:0,
                          right:0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColor.mainColor,
                          ),

                        )
                            :Container(),

                        Get.find<PopularProductController>().totalItems>=1?Positioned(
                          top:3,
                          right:3,

                          child: BigText(
                            text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),

                        )
                            :Container(),
                      ],
                    ),
                  );
                },),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height320,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),

              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20),topLeft: Radius.circular(Dimensions.radius20),)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                  ),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20,),
                 Expanded(child:  SingleChildScrollView(
                   child: ExpandableTextWidget(
                     text:
                     product.description!,
                   ),
                 ),),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            ),
            color: AppColor.buttonBackgroundColor,

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
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
                        popularProduct.setQuantity(false);
                      },
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItem.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColor.signColor,
                      ),
                    ),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColor.mainColor,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: BigText(
                      text: "\$ ${product.price!} | Add to card",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
