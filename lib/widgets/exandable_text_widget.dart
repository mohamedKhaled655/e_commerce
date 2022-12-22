

import 'package:e_commerce/utills/colors.dart';
import 'package:e_commerce/utills/diminsions.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key,required this.text}) : super(key: key);


  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  double textHeight=Dimensions.screenHeight/7;

  @override
  void initState() {

    super.initState();
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }
    else{
      firstHalf=widget.text;
      secondHalf="";

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,maxLine: 3,height: 1.8,size: 16,):Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          SmallText(
              text: hiddenText?(firstHalf+"..."):firstHalf+secondHalf,
            maxLine: textHeight.toInt(),
            height: 1.8,size: 16,
          ),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText =!hiddenText;
                print(hiddenText);
               // print(secondHalf);
                print(firstHalf);


              });
            },
            child: Row(
              children: [
                SmallText(text:hiddenText? "Show more":"Show less",color: AppColor.mainColor,height: 1.8,size: 16,),
                Icon(hiddenText? Icons.arrow_drop_down:Icons.arrow_drop_up_rounded,color: AppColor.mainColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

