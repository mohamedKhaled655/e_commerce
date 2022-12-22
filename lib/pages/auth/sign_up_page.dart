
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/models/signup_body_model.dart';
import 'package:e_commerce/pages/auth/sign_in_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snakbar.dart';
import '../../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();

    List signUpImages=[
      "assets/images/face.png",
      "assets/images/tw.png",
      "assets/images/i.png",
    ];

    void _registeration(AuthController authController){
    //  var authController=Get.find<AuthController>();
      String name=nameController.text.trim();
      String phone=phoneController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(name.isEmpty){
        ShowCustomSnackBar(
          "Enter your name ",
          title: "Name"
        );
      }
      else if(phone.isEmpty){
        ShowCustomSnackBar(
            "Enter your phone ",
            title: "Phone"
        );
      }
      else if(email.isEmpty){
        ShowCustomSnackBar(
            "Enter your Email Address ",
            title: "Email"
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
        SignUpBodyModel signUpBodyModel= SignUpBodyModel(
          name: name,
          email: email,
          password: password,
          phone: phone,);
        authController.registration(signUpBodyModel).then((status){
          if(status.isSuccess){
            print("Success Registration");
            Get.snackbar("Registration", "Success");
            Get.offNamed(RouteHelper.getInitial());
          }
          else{
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return(!_authController.isLoading)? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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

              AppTextField(
                hintText: "Email",
                textEditingController:emailController,
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
              //name
              AppTextField(
                icon: Icons.person,
                hintText: "Name",
                textEditingController:nameController ,
                textInputType: TextInputType.name,

              ),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(
                icon: Icons.numbers,
                hintText: "phone",
                textEditingController:phoneController ,
                textInputType: TextInputType.phone,

              ),


              SizedBox(height: Dimensions.height20,),
              //sign up
              GestureDetector(
                onTap: (){
                  _registeration(_authController);
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
                      text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font10,
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),

              //tag line
              RichText(
                text: TextSpan(
                  text: "Have an account already?",
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*.05,),
              //sign up option
              RichText(
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font15+2,
                  ),
                ),
              ),
              Wrap(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                        signUpImages[index],
                      ),
                    ),
                  );
                }),
              ),

            ],
          ),
        ):CustomLoader();
      },),
    );
  }
}
