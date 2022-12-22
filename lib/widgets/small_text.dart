
import 'package:e_commerce/utills/colors.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color ?color;
  final String text;
  double size;
  FontWeight fontWeight;
double height;
int maxLine;

  SmallText({Key? key,this.size=12,
    this.color=const Color(0xFFccc7c5),
    required this.text,this.fontWeight=FontWeight.normal,this.height=1.2,
    this.maxLine=1,
  })
      : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: TextStyle(

        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        height: height,
      ),
      maxLines: maxLine,
    );
  }
}
