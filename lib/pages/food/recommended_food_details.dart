

import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_icon_bar.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utills/app_constance.dart';
import '../../widgets/exandable_text_widget.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  String page;
   RecommendedFoodDetails({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommended=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    print("page id is "+pageId.toString());
    print("product is "+recommended.name.toString());
    Get.find<PopularProductController>().initProduct(recommended,Get.find<CartController>());


    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20),topRight:Radius.circular(Dimensions.radius20) ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      child: AppIcon(icon: Icons.remove,backgroundColor: AppColor.mainColor,),
                    onTap: (){
                      controller.setQuantity(false);
                    },
                  ),
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: "\$ ${recommended.price!} X ${controller.inCartItem}"),
                  SizedBox(width: Dimensions.width10/2,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(icon: Icons.add,backgroundColor: AppColor.mainColor,)),

                ],
              ),
            ),
            Container(
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
                  AppIcon(icon: Icons.favorite,backgroundColor: Colors.white,iconColor: AppColor.mainColor,size: 50,),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(recommended);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColor.mainColor,
                      ),
                      child: BigText(
                        text: "\$${recommended.price!*controller.inCartItem} | Add to card",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: Dimensions.height45*2,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                  child: AppIcon(icon: Icons.clear),
                  onTap: (){
                    if(page=="cartpage")
                    {
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }


                  },
                ),
                GetBuilder<PopularProductController>(builder:(controller) {
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                       Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.add_shopping_cart,
                        ),
                        Get.find<PopularProductController>().totalItems>=1?Positioned(
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
            backgroundColor: AppColor.yellowColor,
            pinned: true,
            expandedHeight: Dimensions.height300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+'/uploads/'+recommended.img!,fit: BoxFit.cover,width: double.maxFinite,),


            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10/3,bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius30),topLeft: Radius.circular(Dimensions.radius30),)
                  ),
                  child: Center(child: BigText(text: recommended.name!,size: Dimensions.font30,)),
              ),
            ),

          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(

                  child: ExpandableTextWidget(

                    text: recommended.description!,
                  ),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                ),


              ],
            ),

          ),
        ],
      ),
    );
  }
}
