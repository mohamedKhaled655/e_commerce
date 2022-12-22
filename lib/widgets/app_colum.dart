
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  double size;

   AppColumn({Key? key,required this.text,this.size=26}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size:size ,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {return Icon(Icons.star,color: AppColor.mainColor,size: Dimensions.font15,);}),
            ),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "1287"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "Comment"),
          ],
        ),
        SizedBox(height: Dimensions.height10,),
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
    );
  }
}
