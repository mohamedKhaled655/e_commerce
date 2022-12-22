
import 'package:e_commerce/utills/colors.dart';
import 'package:flutter/material.dart';

import '../utills/diminsions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
   bool isObscure;
  TextInputType textInputType;

   AppTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.icon,
    this.textInputType=TextInputType.text,
     this.isObscure=false,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(1,1),
            color: Colors.grey.withOpacity(.2),
          ),
        ],
      ),
      child: TextField(
        controller:textEditingController ,
        keyboardType: textInputType,
        obscureText: isObscure?true:false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon,color: AppColor.yellowColor,),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),


        ),
      ),
    );
  }
}
