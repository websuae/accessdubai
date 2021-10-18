import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/model/Nationality.dart';
import 'package:visa_app/ui/HomeModule/conotroller/homeController.dart';
import 'package:visa_app/ui/applyVisaModule/view/applyVisaScreen.dart';
import 'package:visa_app/widget/commonAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _countryDropDownName = "Traveling to";
  List<String> countryNameList = <String>[
    "UAE",
    "India",
    "Australia",
    "USA",
    "Japan"
  ];
  HomeController controller = Get.put(HomeController());

  FocusNode nationalityFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          appBar: CommonAppBar(
            appBar: AppBar(),
            isLeading: false,
            action: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Image.asset(
                  logo,
                  height: 35.h,
                  width: 35.h,
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10.h, right: 10.h),
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
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
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: Text(
                        "Your UAE Visa Processed \nSimple and Esay",
                        style: TextStyle(fontSize: 14.sp, color: colorWhite),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 30.w, right: 30.w, top: 30.h, bottom: 40.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5.w),
                            height: 35.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                                border:
                                Border.all(color: Colors.grey.shade300)),
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconEnabledColor: colorBlue,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  hint: _countryDropDownName == null
                                      ? Text('Treveling to')
                                      : Text(
                                    _countryDropDownName!,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items: countryNameList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.h),
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      print("value:" + value.toString());
                                      _countryDropDownName = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          FutureBuilder(
                              future: ReadJsonData(),
                              builder: (context, data) {
                                if (data.hasError) {
                                  //in case if error found
                                  return Center(child: Text("${data.error}"));
                                } else if (data.hasData) {
                                  var items = data.data as List<Nationality>;
                                  return Container(
                                    padding: EdgeInsets.only(left: 5.w),
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.shade100,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isDense: true,
                                          isExpanded: true,
                                          focusNode: nationalityFocus,
                                          iconEnabledColor: colorBlue,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          alignment: Alignment.centerRight,
                                          hint: Obx(
                                                () => controller.countryDropDownName
                                                .value ==
                                                ""
                                                ? Text('For Citizen of',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                    FontWeight.bold))
                                                : Text(
                                              controller
                                                  .countryDropDownName
                                                  .value,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          items: items.map((dynamic value) {
                                            return DropdownMenuItem<String>(
                                              value: value.name,
                                              child: Text(
                                                value.name.toString(),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.countryDropDownName
                                                .value = value.toString();
                                            controller
                                                .countryDropDownName.value;
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    color: Colors.red,
                                  );
                                }
                              }),
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                              child: Container(
                                padding:
                                EdgeInsets.only(left: 10.w, right: 10.w),
                                height: 40.h,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: colorYellow),
                                child: Center(
                                  child: Text(
                                    "Apply now",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () => Get.to(ApplyVisaPage())),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.all(0.h),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            visaImage,
                            height: 40.h,
                            width: 60.w,
                          ),
                          Image.asset(
                            vectorImage,
                            height: 40.h,
                            width: 60.w,
                          ),
                          Image.asset(
                            markerImage,
                            height: 40.h,
                            width: 60.w,
                          ),
                          Image.asset(
                            vectorImage2,
                            height: 40.h,
                            width: 60.w,
                          ),
                          Image.asset(
                            vectorImage3,
                            height: 40.h,
                            width: 60.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40.h,
                            width: 60.w,
                            child: Text(
                              "TYPE OF\nVISA",
                              style: TextStyle(
                                  color: colorLightBlue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            child: Text(
                              "HOW TO\nAPPLY",
                              style: TextStyle(
                                  color: colorLightBlue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            child: Text(
                              "TRACK\nAPPLICATION",
                              style: TextStyle(
                                  color: colorLightBlue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            child: Text(
                              "FREQUANTLY\nASK\nQUESTION",
                              style: TextStyle(
                                  color: colorLightBlue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            child: Text(
                              "CONTACT\nUS",
                              style: TextStyle(
                                  color: colorLightBlue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
