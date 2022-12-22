

import 'dart:convert';

import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/app_constance.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_icon_bar.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to reversed to list عشان اعرض اللي اضاف في الاخر يظهر الاول
    var getCartHistoryList=Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String,int>cartItemParOrder=Map();
    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemParOrder.containsKey(getCartHistoryList[i].time!)){
        cartItemParOrder.update(getCartHistoryList[i].time!,(value)=>++value);

      }
      else{
        cartItemParOrder.putIfAbsent(getCartHistoryList[i].time!,() => 1,);
      }
    }
    // print(cartItemParOrder);

    List<int>cartItemPerOrderToList(){
      return cartItemParOrder.entries.map((e)=>e.value).toList();
    }
    List<int> ItemPerOrder=cartItemPerOrderToList();
    // print(orderTimes);
    List<String>cartOrderTimeToList(){
      return cartItemParOrder.entries.map((e)=>e.key).toList();
    }
    List<String >orderTime=cartOrderTimeToList();

    var saveCounter=0;
    // for(int i=0;i<cartItemParOrder.length;i++)
    // {
    //   for(int j=0;j<orderTimes[i];j++)
    //   {
    //     print("Index of order= ${j}");
    //     print("My order is = ${getCartHistoryList[saveCounter++]}");
    //   }
    // }
    Widget timeWidget(int index){
      return  (){
        var outputDate=DateTime.now().toString();

        if(index<getCartHistoryList.length)
          {
            DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[saveCounter].time!);
            var inputDate=DateTime.parse(parseDate.toString());
            var outFormat=DateFormat("mm/dd/yyyy hh:mm a");
             outputDate=outFormat.format(inputDate);

          }
        return BigText(text: outputDate);
      }();
    }
    return Scaffold(
      body: Column(

        children: [
          Container(
            height: Dimensions.height100,
            color: AppColor.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColor.mainColor,iconSize: Dimensions.font20),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return(cartController.getCartHistoryList().length>0)? Expanded(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for(int i=0;i<ItemPerOrder.length;i++)
                        Container(
                          // height:192,
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              timeWidget(saveCounter),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(ItemPerOrder[i], (index) {
                                      if(saveCounter<getCartHistoryList.length)
                                      {
                                        ++saveCounter;
                                      }
                                      return(index<=2)? Container(
                                        height: Dimensions.height80,
                                        width: Dimensions.height80,
                                        margin: EdgeInsets.only(right:5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                          image: DecorationImage(

                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL+'/uploads/'+getCartHistoryList[saveCounter-1].img!
                                            ),
                                          ),
                                        ),
                                      ):Container();
                                    }),
                                  ),
                                  Container(

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallText(text: "total"),
                                        BigText(text: "${ItemPerOrder[i]} items"),
                                        GestureDetector(
                                          onTap: (){
                                            print("Doing Test ${ItemPerOrder[i]}");
                                            print("Doing Test ${orderTime[i]}");
                                            Map<int,CartModel>moreOrder={};
                                            for(int j=0;j<getCartHistoryList.length;j++){
                                              if(getCartHistoryList[j].time==orderTime[i])
                                              {
                                                //   print ("product info is "+jsonEncode(getCartHistoryList[j]));
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                                Get.find<CartController>().setItems=moreOrder;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartPage());
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                              border: Border.all(width: 1,color: AppColor.mainColor),
                                            ),
                                            child: SmallText(text: "One more",color: AppColor.mainColor,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),

                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ):
            Expanded(
                child: NoDataPage(
                    text: "You didn't buy anything so far ! ",

                ));
          }),
        ],
      ),
    );
  }
}
