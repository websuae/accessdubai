import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/HomeModule/view/homeScreen.dart';
import 'package:visa_app/ui/SplashModule/splashController.dart';
import 'package:visa_app/ui/signInModule/view/signInScreen.dart';
import 'package:visa_app/ui/signUpModule/view/signUpScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1800), () {
      controller.isVisible.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff0172D8),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Text(
                        "Skip",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      onTap: () => Get.offAll(HomePage()),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Image.asset(
                      logo,
                      height: 100.h,
                      width: 100.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Your UAE Visa Processed \n Simple and Easy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: colorWhite,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.60,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(
                  splash,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isVisible.value,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              height: 35.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorYellow),
                              child: Center(
                                child: Text(
                                  signInText,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: colorWhite),
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.offAll(SignIn());
                            }),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isVisible.value,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: InkWell(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              height: 35.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: colorYellow),
                              child: Center(
                                child: Text(
                                  signUpText,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: colorWhite),
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.offAll(SignUp());
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
