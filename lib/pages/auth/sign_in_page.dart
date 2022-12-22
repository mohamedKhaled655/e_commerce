
import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/pages/auth/sign_up_page.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snakbar.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_text_field.dart';
import '../home/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController=TextEditingController();
    var passwordController=TextEditingController();

    void _login(AuthController authController){

      String phone=phoneController.text.trim();
      String password=passwordController.text.trim();



       if(phone.isEmpty){
        ShowCustomSnackBar(
            "Enter your Phone",
            title: "Phone"
        );
      }
      // else if(GetUtils.isEmail(email)){
      //   ShowCustomSnackBar(
      //       "Enter your valid Email ",
      //       title: "Email"
      //   );
      // }
      else if(password.isEmpty){
        ShowCustomSnackBar(
            "Enter your password ",
            title: "password"
        );
      }
      else if(password.length<6){
        ShowCustomSnackBar(
            "Password can't be less than six characters ! ",
            title: "password"
        );
      }
      else{
        ShowCustomSnackBar(
          "All went well ",
          title: "Perfect",
          background: AppColor.mainColor,
        );

        authController.login(phone,password).then((status){
          if(status.isSuccess){
            Get.snackbar("Login", "Success");
            Get.to(HomePage());
          }
          else{
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return(!authController.isLoading)? SingleChildScrollView(

          child: Column(

            children: [
              SizedBox(height: Dimensions.screenHeight*.05,),
              Container(
                height: Dimensions.screenHeight*.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo2.png"),
                    radius: Dimensions.radius20*4,
                    backgroundColor: Colors.white,

                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*4-10,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SmallText(text: "Sign into your Account"),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              AppTextField(
                hintText: "Phone",
                textEditingController:phoneController,
                icon: Icons.email,
              ),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(
                icon: Icons.password,
                hintText: "password",
                isObscure: true,
                textEditingController:passwordController ,

              ),
              SizedBox(height: Dimensions.height20,),

              //tag line
              Row(

                children: [
                  Expanded(child: Container()),
                  RichText(
                    text: TextSpan(
                      text: "Sign into your account",
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width20,),
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*.05,),
              //sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColor.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign In",
                      size: Dimensions.font20+Dimensions.font10,
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*.05,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account ?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font15+2,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Create",
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fadeIn),

                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font15+2,
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ):CustomLoader();
      },),
    );
  }
}
