

import 'package:e_commerce/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({Key? key,required this.text, this.imgPath="assets/images/e.png"}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center ,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*.22,
          width: MediaQuery.of(context).size.width*.22,

        ),
        SizedBox(height: MediaQuery.of(context).size.height*.05,),
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height*.0175,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      ],
    );
  }
}
