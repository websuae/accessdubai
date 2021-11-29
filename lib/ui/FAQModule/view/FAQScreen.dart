import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/FAQModule/controller/faqController.dart';
import 'package:visa_app/ui/applyVisaModule/view/expandableListViewScreen.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  FaqController controller = Get.put(FaqController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool isOnline = await hasNetwork();
      if(isOnline)  {
        controller.faqApi();
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
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "F.A.Q.",
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
        Obx(
              () =>

              controller.faqList != null &&
              controller.faqList.length > 0
              ?

                  ListView.builder(
                      shrinkWrap: true,
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: controller.faqList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                              child: ExpandableListView(
                            que: controller.faqList[index].fque.toString(),
                            ans: controller.faqList[index].fans.toString(),
                          )),
                        );
                      }): controller.loader.value?Center(child: CircularProgressIndicator()):Container())
                ],
              ),
            ),
          ),
          bottomNavigationBar: CommonBottomNavigation()),
    );
  }
}

class SelectIndex {
  String? value;
  bool? isSelected;

  SelectIndex({this.value, this.isSelected});
}
