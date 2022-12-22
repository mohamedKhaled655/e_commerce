

import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ShowCustomSnackBar(String message,{bool isError=true,String title="Error",Color background=Colors.redAccent}){
  Get.snackbar(
      title,
      message,
    titleText: BigText(text: title,color: Colors.white,),
    messageText: Text(message,style:TextStyle(
      color: Colors.white,

    ) ,),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: background,
  );
}
