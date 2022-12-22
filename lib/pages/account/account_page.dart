

import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_icon_bar.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn)
      {
        Get.find<UserController>().getUserInfo();
      }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: Dimensions.font20+4,
            color: Colors.white,
          ),
        ),

      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              AppIcon(icon: Icons.person,
                iconSize: Dimensions.font15*6,
                size: Dimensions.font30*6,
                iconColor:AppColor.buttonBackgroundColor,
                backgroundColor: AppColor.mainColor,
              ),
              SizedBox(height: Dimensions.height45,),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                        appIcon: AppIcon(icon: Icons.person,
                          iconSize: Dimensions.font20+5,
                          size: Dimensions.font30*1.5,
                          iconColor:AppColor.buttonBackgroundColor,
                          backgroundColor: AppColor.mainColor,
                        ),
                        bigText: BigText(text: userController.userModel.name),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //phone
                      AccountWidget(
                        appIcon: AppIcon(icon: Icons.phone,
                          iconSize: Dimensions.font20+5,
                          size: Dimensions.font30*1.5,
                          iconColor:AppColor.buttonBackgroundColor,
                          backgroundColor: AppColor.yellowColor,
                        ),
                        bigText: BigText(text:userController.userModel.phone),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                        appIcon: AppIcon(icon: Icons.email,
                          iconSize: Dimensions.font20+5,
                          size: Dimensions.font30*1.5,
                          iconColor:AppColor.buttonBackgroundColor,
                          backgroundColor: AppColor.yellowColor,
                        ),
                        bigText: BigText(text:userController.userModel.email),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //address
                     GetBuilder<LocationController>(builder: (locationController){

                       if(_userLoggedIn&&locationController.addressList.isEmpty)
                         {
                           return  GestureDetector(
                             onTap: (){
                               Get.offNamed(RouteHelper.getAddAddressPage());
                             },
                             child: AccountWidget(
                               appIcon: AppIcon(icon: Icons.location_on,
                                 iconSize: Dimensions.font20+5,
                                 size: Dimensions.font30*1.5,
                                 iconColor:AppColor.buttonBackgroundColor,
                                 backgroundColor: AppColor.yellowColor,
                               ),
                               bigText: BigText(text: "fill in your location"),
                             ),
                           );
                         }
                       else{
                         return  GestureDetector(
                           onTap: (){
                             Get.offNamed(RouteHelper.getAddAddressPage());
                           },
                           child: AccountWidget(
                             appIcon: AppIcon(icon: Icons.location_on,
                               iconSize: Dimensions.font20+5,
                               size: Dimensions.font30*1.5,
                               iconColor:AppColor.buttonBackgroundColor,
                               backgroundColor: AppColor.yellowColor,
                             ),
                             bigText: BigText(text: "Your Address"),
                           ),
                         );
                       }

                     }),
                      SizedBox(height: Dimensions.height20,),
                      //message
                      AccountWidget(
                        appIcon: AppIcon(icon: Icons.message,
                          iconSize: Dimensions.font20+5,
                          size: Dimensions.font30*1.5,
                          iconColor:AppColor.buttonBackgroundColor,
                          backgroundColor: Colors.redAccent,
                        ),
                        bigText: BigText(text: "message"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn())
                          {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
                          else{
                            print("log out");
                          }

                        },
                        child: AccountWidget(
                          appIcon: AppIcon(icon: Icons.logout,
                            iconSize: Dimensions.font20+5,
                            size: Dimensions.font30*1.5,
                            iconColor:AppColor.buttonBackgroundColor,
                            backgroundColor: Colors.redAccent,
                          ),
                          bigText: BigText(text: "Logout"),
                        ),
                      ),

                    ],
                  ),
                ),
              ),


            ],
          ),
        ):CustomLoader()):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height100+Dimensions.height20,
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/f1.png"),
                ),
              ),
              child: Text("",
              ),),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());

              },
              child: AccountWidget(
                appIcon: AppIcon(icon: Icons.logout,
                  iconSize: Dimensions.font20+5,
                  size: Dimensions.font30*1.5,
                  iconColor:AppColor.buttonBackgroundColor,
                  backgroundColor: Colors.redAccent,
                ),
                bigText: BigText(text: "Login"),
              ),
            ),
          ],
        );
      },),
    );
  }
}
