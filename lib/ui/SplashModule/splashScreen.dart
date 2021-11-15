import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
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
  bool boolValue = false;

  final storage = GetStorage();

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    if (prefs.containsKey(isLogin)) {
      print("name of user"+prefs.getString(userName).toString());
      return prefs.getBool(isLogin)!;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      boolValue = await getBoolValuesSF();

      setState(() {
        boolValue;
      });
      print("bool value:" + boolValue.toString());
    });

    Timer(Duration(milliseconds: 1800), () {
      controller.isVisible.value = true;
    });
    Timer(Duration(seconds: 3), () {
      if (boolValue) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Color(0xff0172D8),
                child: Column(
                  children: [
                    // storage.read(isLogin) != null && storage.read(isLogin)
                    //     ? SizedBox():
                    Padding(
                      padding: EdgeInsets.all(10.h),
                      child: boolValue
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                child: Text(
                                  "Skip",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
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
                          new_logo,
                          height: 120.h,
                          width: 130.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      splash,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    boolValue
                        ? SizedBox()
                        : Obx(
                            () => Visibility(
                              visible: controller.isVisible.value,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        height: 35.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: colorYellow),
                                        child: Center(
                                          child: Text(
                                            signInText,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: colorWhite),
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
                    boolValue
                        ? SizedBox()
                        : Obx(
                            () => Visibility(
                              visible: controller.isVisible.value,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        height: 35.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: colorYellow),
                                        child: Center(
                                          child: Text(
                                            signUpText,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: colorWhite),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
