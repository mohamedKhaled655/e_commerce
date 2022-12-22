
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../widgets/big_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await  Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    print("h=${MediaQuery.of(context).size.height}");
    print("w=${MediaQuery.of(context).size.width}");

    return RefreshIndicator(child: Column(
      children: [
        Container(

          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height20),
            padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  children: [
                    BigText(
                      text: "Bangladesh",
                      color: AppColor.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "Narsinqdi",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down,)
                      ],
                    ),

                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.mainColor,
                    ),
                    child: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: FoodPageBody()),),
      ],
    ), onRefresh: _loadResources);
  }
}
