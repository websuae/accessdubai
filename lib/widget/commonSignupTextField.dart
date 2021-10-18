import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonSignUpTextField extends StatelessWidget {
  BuildContext context;
  String hintText;
  int maxLine;
  FocusNode? focusNode;
  TextInputType textInputType;
  TextInputAction textInputAction;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  IconData? suffixIcon;
  Function()? onTap;
  bool? isDivider = true;


  CommonSignUpTextField(
      {required this.context,
      required this.hintText,
      required this.maxLine,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.suffixIcon,
        this.onTap,
      required this.textInputType,
      required this.textInputAction,
       this.isDivider,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        maxLines: null,
        onTap:onTap ,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            isDense: true,

            suffixIcon: Container(
              child: Padding(
                padding: EdgeInsets.only(right: 15.0.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min ,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isDivider! ?
                    Container(
                      height: 20.h,
                      width: 1.h,
                      color: Colors.grey.shade400,
                    ) :
                    Container(),
                    SizedBox(width: 10.w),
                    InkWell(
                      child: Icon(
                        suffixIcon,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal)),
        controller: controller,
      ),
    );
  }
}
