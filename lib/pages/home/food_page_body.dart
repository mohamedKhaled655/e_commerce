
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_colum.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/icon_and_text_widget.dart';
import '../food/popular_food_detial.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController=PageController(viewportFraction: .85);
  var _currentPageValue=0.0;
  double _scaleFactor=.8;
  double _height=Dimensions.pageViewContainer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue=pageController.page!;

      });

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
    ///دي عشان ميفضلش يسحب من الميموري وانا في بيدج تانيه
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded==true? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context,position){
                return _buildItem(position,popularProducts.popularProductList[position]);
              },
              scrollDirection: Axis.horizontal,
              itemCount: popularProducts.popularProductList.length,
            ),
          ):Center(child: CircularProgressIndicator(color: AppColor.mainColor,));
        } ),
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return DotsIndicator(

            dotsCount:popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length ,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColor.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        } ),


        //Popular text
        SizedBox(height: Dimensions.height30,),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
                child: BigText(text: "Recommended"),
            ),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "."),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "Food pairing"),
          ],
        ),

        ///List of Food and Images
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            //physics: BouncingScrollPhysics(),
            itemCount: recommendedProducts.recommendedProductList.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              AppConstants.BASE_URL+'/uploads/'+recommendedProducts.recommendedProductList[index].img!,
                            ),
                          ),
                        ),
                      ),
                      //text Section
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextConSize,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20,),
                                bottomRight:Radius.circular(Dimensions.radius20,),
                              ),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensions.width10,right:Dimensions.width10 ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: recommendedProducts.recommendedProductList[index].name!,
                                ),
                                SmallText(text: recommendedProducts.recommendedProductList[index].description!),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      text: "Normal",
                                      icon: Icons.circle_sharp,
                                      iconColor: AppColor.iconColor1,
                                    ),

                                    IconAndTextWidget(
                                      text: "1.7km",
                                      icon: Icons.location_on,
                                      iconColor: AppColor.mainColor,
                                    ),

                                    IconAndTextWidget(
                                      text: "32 min",
                                      icon: Icons.access_time_rounded,
                                      iconColor: AppColor.iconColor2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ):CircularProgressIndicator(color: AppColor.mainColor,);
        }),

      ],
    );
  }
  Widget _buildItem(int index,ProductData model){
    Matrix4 matrix=new Matrix4.identity();
    if(index==_currentPageValue.floor())
      {
        var currScale=1-(_currentPageValue.floor()-index)*(1-_scaleFactor);
        var currTrans=_height*(1-currScale)/2;
        matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      }
    else if(index==_currentPageValue.floor()+1){

      var currScale=_scaleFactor+(_currentPageValue-index+1)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else if(index==_currentPageValue.floor()-1){

      var currScale=1-(_currentPageValue.floor()-index)*(1-_scaleFactor);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else{
      var currScale=.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height+(1-_scaleFactor)/2, 1);

    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:index.isEven? Color(0xFF69c5df):Color(0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BASE_URL+'/uploads/'+model.img!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),

            ),
          ),
          Align(
             alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5),//x axis,y axix

                  ),
                  // BoxShadow(
                  //   color: Colors.white,
                  //   blurRadius: 5.0,
                  //   offset: Offset(-5,0),//x axis,y axix
                  //
                  // ),

                ]
              ),
              child: AppColumn(
                text: model.name!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
