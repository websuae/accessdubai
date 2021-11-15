import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';

class HowToApplyPage extends StatelessWidget {
  const HowToApplyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CommonAppBar(
            appBar: AppBar(),
            isLeading: true,
            isFromBottom: true,
            action: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Image.asset(
                  new_logo,
                  height: 50.h,
                  width: 35.h,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 150.h,
                            autoPlay: true,
                            autoPlayInterval: Duration(milliseconds: 1500),
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items: [forgotImage, signinImage].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Center(
                                  child: Image.asset(
                                    "$i",
                                    fit: BoxFit.cover,
                                    height: 150.h,
                                    width:
                                    MediaQuery.of(context).size.width,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Text(
                            "How To Apply",
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: colorWhite),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Column(
                          children: [
                            Image.asset(image1),
                            Image.asset(image2),
                            Image.asset(image3),
                            Image.asset(image4),
                            Image.asset(image5),
                            Image.asset(image6),
                          ],
                    ),
                      ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar:CommonBottomNavigation()
      ),
    );
  }
}
