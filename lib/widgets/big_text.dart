
import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
   Color ?color;
  final String text;
  double size;
  TextOverflow overflow;

   BigText({Key? key,this.overflow=TextOverflow.ellipsis,this.size=20,
     this.color=const Color(0xFF332d2b),required this.text})
       : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
