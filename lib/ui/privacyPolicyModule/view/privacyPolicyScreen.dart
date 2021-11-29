
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/privacyPolicyModule/controller/PrivacyPolicyController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';

class PrivacyPolicyPage extends StatefulWidget {
   PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();

}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  PrivacyPolicyController controller = Get.put(PrivacyPolicyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool isOnline = await hasNetwork();
      if(isOnline)  {
        controller.privacyPolicyApi();
      }
      else{
        Get.snackbar("oops..","Internet not avaliable");
      }

    });

  }

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
                            "Privacy Policy",
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
                  Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Obx(
                            () => controller.privacyPolicyList != null &&
                            controller.privacyPolicyList.length > 0
                            ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.privacyPolicyList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      controller.privacyPolicyList[index]
                                          .privacyName
                                          .toString(),
                                      style: TextStyle(
                                          color: colorBlue,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      controller.privacyPolicyList[index]
                                          .privacyDesc
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),





                                  ],
                                ),
                              );
                            })
                            :controller.loader.value? Center(child: CircularProgressIndicator()):Container(),
                      ))
                ],
              ),
            ),
          ),
          bottomNavigationBar:CommonBottomNavigation()
      ),
    );
  }
}
