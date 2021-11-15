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
import 'package:visa_app/ui/HomeModule/conotroller/homeController.dart';
import 'package:visa_app/ui/HomeModule/model/countryModel.dart';
import 'package:visa_app/ui/applyVisaFirstStepModule/view/selectVisaPlanScreen.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _countryDropDownName = "UAE";
  List<String> countryNameList = <String>[
    "UAE",
  ];
  String selectedCountry = "";

  HomeController controller = Get.put(HomeController());

  FocusNode nationalityFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    controller.getCountryListApi("");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
    controller.countryDropDownName.value="";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // To close whole application on onBack
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
                    new_logo,
                    height: 50.h,
                    width: 35.h,
                  ),
                )
              ],
            ),
            body: Obx(
              () => controller.loader.value
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h, right: 10.h),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 150.h,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        Duration(milliseconds: 1500),
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
                                        ));
                                      },
                                    );
                                  }).toList(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.h),
                                  child: Text(
                                    "Your UAE Visa Processed \nSimple and Esay",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: colorWhite),
                                  ),
                                ),
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
                                    left: 30.w,
                                    right: 30.w,
                                    top: 30.h,
                                    bottom: 40.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 5.w),
                                        height: 38.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade100,
                                            border: Border.all(
                                                color: Colors.grey.shade300)),
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
                                                hint: _countryDropDownName ==
                                                        null
                                                    ? Text('UAE')
                                                    : Text(
                                                        _countryDropDownName!,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                items: countryNameList
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.h),
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: null),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      // FutureBuilder(
                                      //     future:  controller.getCountryListApi(),
                                      //     builder: (context, data) {
                                      // if (data.hasError) {
                                      //   //in case if error found
                                      //   return Center(child: Text("${data.error}"));
                                      // }
                                      // else if (data.hasData) {
                                      // Container(
                                      //   padding: EdgeInsets.only(left: 5.w),
                                      //   height: 38.h,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius:
                                      //         BorderRadius.circular(15),
                                      //     color: Colors.grey.shade100,
                                      //     border: Border.all(
                                      //         color: Colors.grey.shade300),
                                      //   ),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.all(10.h),
                                      //     child: DropdownButtonHideUnderline(
                                      //       child: DropdownButton<Country>(
                                      //         isDense: true,
                                      //         isExpanded: true,
                                      //         focusNode: nationalityFocus,
                                      //         iconEnabledColor: colorBlue,
                                      //         icon: Icon(
                                      //           Icons.arrow_drop_down,
                                      //         ),
                                      //         hint: Obx(
                                      //           () => controller
                                      //                       .countryDropDownName
                                      //                       .value ==
                                      //                   ""
                                      //               ? Text('For Citizen of',
                                      //                   style: TextStyle(
                                      //                       color: Colors.grey,
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .bold))
                                      //               : Text(
                                      //                   controller
                                      //                       .countryDropDownName
                                      //                       .value,
                                      //                   style: TextStyle(
                                      //                       color: Colors.grey,
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .bold),
                                      //                 ),
                                      //         ),
                                      //         items: controller.countryList
                                      //             .map((value) {
                                      //           return DropdownMenuItem<
                                      //               Country>(
                                      //             value: value,
                                      //             child: Text(
                                      //               value.countryName
                                      //                   .toString(),
                                      //               style:
                                      //                   TextStyle(fontSize: 15),
                                      //             ),
                                      //           );
                                      //         }).toList(),
                                      //         onChanged: (value) {
                                      //           Country countryName;
                                      //           countryName = value as Country;
                                      //           setState(() {
                                      //             controller.countryDropDownName
                                      //                     .value =
                                      //                 countryName.countryName
                                      //                     .toString();
                                      //             selectedCountry = countryName
                                      //                 .countryId
                                      //                 .toString();
                                      //           });
                                      //         },
                                      //       ),
                                      //     ),
                                      //   ),
                                      //
                                      // ),

                                        GestureDetector(
                                          onTap: (){
                                            showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext context) => AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(20),
                                                            ),
                                                          ),
                                                          content: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                height: 40.h,
                                                               // width: MediaQuery.of(context).size.width,
                                                                decoration: BoxDecoration(color: colorLightGrey, borderRadius: BorderRadius.circular(10)),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(width: 10.h,),
                                                                    Padding(
                                                                      padding:  EdgeInsets.only(top: 5.h),
                                                                      child: Image.asset(searchImage,color: Colors.grey,height: 15.h,width: 15.h,),
                                                                    ),
                                                                    Expanded(
                                                                      child: TextField(
                                                                        textInputAction: TextInputAction.search,
                                                                        keyboardType: TextInputType.text,
                                                                        onChanged: (value){
                                                                          print("api call");
                                                                          controller.serchValue=value;
                                                                          controller.getCountryListApi(value);
                                                                        },

                                                                        decoration: InputDecoration(
                                                                          border: InputBorder.none,),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                                // Stack(
                                                                //   children: [
                                                                //     Container(
                                                                //       height:20.h,
                                                                //       child: TextField(
                                                                //         textInputAction: TextInputAction.search,
                                                                //         keyboardType: TextInputType.text,
                                                                //       ),
                                                                //     ),
                                                                //   ],
                                                                // ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                             Obx(()=> Container(
                                                                height: 300.h,
                                                                width: 200.h,
                                                                child: ListView.builder(
                                                                    shrinkWrap: true,
                                                                    scrollDirection: Axis.vertical,
                                                                    itemCount: controller.countryList.length,
                                                                    itemBuilder:(context,index){
                                                                      return GestureDetector(
                                                                        onTap: (){
                                                                          Navigator.pop(context);
                                                                          controller
                                                                              .countryDropDownName
                                                                              .value= controller.countryList[index].countryName;
                                                                          selectedCountry = controller.countryList[index].countryId
                                                                              .toString();
                                                                        },
                                                                        child: Padding(
                                                                          padding:  EdgeInsets.only(top: 3.h),
                                                                          child: Text(controller.countryList[index].countryName),
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),)
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },

                                            child:  Container(
                                              padding: EdgeInsets.only(left: 5.w),
                                              height: 38.h,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                color: Colors.grey.shade100,
                                                border: Border.all(
                                                    color: Colors.grey.shade300),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Obx(
                                                        () => controller
                                                        .countryDropDownName
                                                        .value ==
                                                        ""
                                                        ? Padding(
                                                          padding:  EdgeInsets.all(10.h),
                                                          child: Text('For Citizen of',
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                        )
                                                        : Padding(
                                                          padding:  EdgeInsets.all(10.h),
                                                          child: Text(
                                                      controller
                                                            .countryDropDownName
                                                            .value,
                                                      style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                    ),
                                                        ),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.all(10.h),
                                                  //   child:Text("For Citizen of", style: TextStyle(
                                                  //       color: Colors.grey,
                                                  //       fontWeight:
                                                  //       FontWeight
                                                  //           .bold)),
                                                  // ),
                                                  Align(child: Icon(Icons.arrow_drop_down_sharp),alignment: Alignment.centerRight,)
                                                ],
                                              ),

                                            ),),

                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      InkWell(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.w, right: 10.w),
                                            height: 40.h,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: colorYellow),
                                            child: Center(
                                              child: Text(
                                                "Apply now",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: colorWhite,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            print("selectedCountry:"+selectedCountry);
                                            if(selectedCountry ==  "" || selectedCountry == null) {
                                              Get.snackbar("Oopsss...!", "Please select a country");
                                            }
                                           else {
                                              controller.countryDropDownName.value="";
                                              Get.to(SelectVisaPlanPage(
                                                selectedCountry: selectedCountry,
                                              ));
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            bottomNavigationBar: CommonBottomNavigation()),
      ),
    );
  }
}
