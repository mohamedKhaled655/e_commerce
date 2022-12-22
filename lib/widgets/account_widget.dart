

import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/app_icon_bar.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
   AccountWidget({Key? key,required this.appIcon,required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(
        left: Dimensions.width20,
        bottom: Dimensions.width10,
        top: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,5),
            color: Colors.grey.withOpacity(.2)
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,
        ],
      ),
    );
  }
}
