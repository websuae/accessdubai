import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/FAQModule/view/FAQScreen.dart';
import 'package:visa_app/ui/chatWithUsModule/view/chatWithUsScreen.dart';
import 'package:visa_app/ui/contactUsModule/view/contactUsScreen.dart';
import 'package:visa_app/ui/howToApplyModule/view/howToApplyScreen.dart';
import 'package:visa_app/ui/typesOfVisaModule/view/typesOfVisaScreen.dart';

import 'commonAppBar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: CommonAppBar(
          appBar: AppBar(),
          isLeading: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      logo,
                      height: 80.h,
                      width: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        children: [
                          Text(
                            nameText,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                             Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 25.h),
                            child: Text(
                              "user@gmail.com",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                drawerWidget("Home", Icons.home, () {
                  Navigator.pop(context);
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Types of visa", Icons.home, () {
                  Get.to(TypesOfVisaPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("How to apply", Icons.home, () {
                  Get.to(HowToApplyPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("F.A.Q.", Icons.home, () {
                  Get.to(FAQPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Chat with us", Icons.home, () {
                  Get.to(ChatWithUsPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Contact us", Icons.home, () {
                  Get.to(ContactUsPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Privacy Policy", Icons.home, () {
                  Get.to(ContactUsPage());
                }),
                Spacer(),
                drawerWidget("Logout", Icons.logout, () {
                  print("Logout");
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget drawerWidget(String text, IconData icon, Function() onClick) {
  return Padding(
    padding: EdgeInsets.all(5.h),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            onClick();
          },
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 10.w,
              ),
              Text(
                text,
              ),
              Spacer(),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ],
    ),
  );
}
