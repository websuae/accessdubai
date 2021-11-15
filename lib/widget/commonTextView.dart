import 'package:flutter/material.dart';
import 'package:visa_app/constants/appColor.dart';

class CommonText extends StatefulWidget {
  BuildContext context;
  String textHint;
  bool isHalfScreen = false;

  CommonText ({required this.textHint, required this.context, required this.isHalfScreen});

  @override
  _CommonTextState createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    print("abcd"+ widget.isHalfScreen.toString());
     return Container(
       height: 50,
       width: !widget.isHalfScreen? MediaQuery.of(context).size.width:MediaQuery.of(context).size.width/2.4,
       color: colorLightGrey,
       child: Padding(
         padding: EdgeInsets.all(10.0),
         child: Center(child: Text(widget.textHint)),
       ),
     );
  }
}