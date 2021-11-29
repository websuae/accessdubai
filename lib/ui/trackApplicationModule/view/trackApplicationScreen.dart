import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/applyVisaModule/controller/applyVisaController.dart';
import 'package:visa_app/ui/trackApplicationModule/controller/TrackApplicationController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';
import 'package:visa_app/widget/commonTextView.dart';

class TrackApplicationPage extends StatefulWidget {

  final String? applicationNumber;
  const TrackApplicationPage({Key? key,this.applicationNumber}) : super(key: key);

  @override
  State<TrackApplicationPage> createState() => _TrackApplicationPageState();
}

class _TrackApplicationPageState extends State<TrackApplicationPage> {
  ApplyVisaController controller = Get.put(ApplyVisaController());
  TrackApplicationController trackController = Get.put(TrackApplicationController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.cleanController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool isOnline = await hasNetwork();
      if(isOnline)  {
        if(widget.applicationNumber != "") {
          trackController.applicationNumberController.text = widget.applicationNumber!;
          trackController.doTrackingApi();
        }
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
        backgroundColor: colorWhite,
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
        body:
        Obx(()=>
        trackController.loader.value?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(10.h),
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
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Center(
                        child: Text(
                          "UAE VISA apply \nonline",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: colorWhite),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 90.h, right: 15.w, left: 15.w),
                      child: Stack(
                        children: [
                          Container(
                            height: 40.h,
                            child: CommonSignUpTextField(
                                context: context,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: trackController.applicationNumberController,
                                hintText: "9T4V88UOtWi",
                                maxLine: 1,
                                isShowCursor: true,
                                isDivider: false,
                                suffixIcon: null),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: colorYellow),
                              height: 40.h,
                              width: 38.h,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              print("Response");
                              bool isOnline = await hasNetwork();
                              if(isOnline)  {
                                trackController.doTrackingApi();
                              }
                              else{
                                Get.snackbar("oops..","Internet not avaliable");
                              }

                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: colorBlue),
                                height: 40.h,
                                width: 35.h,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: colorYellow,
                                    )),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                trackController.userApplication.length>0?SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        "Application Number",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
                        child: CommonText(
                            textHint: trackController.trackApplicationModel.applicationData!.applicationNumber.toString(),
                            context: context,
                            isHalfScreen: false),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 18.w),
                            child: Column(
                              children: [
                                Text(
                                  "Applied For",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.h),
                                CommonText(
                                    textHint: "New Visa",
                                    context: context,
                                    isHalfScreen: true),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.h),
                          Column(
                            children: [
                              Text(
                                "Type",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.h),
                              CommonText(
                                  textHint: trackController.trackApplicationModel.applicationData!.applicationDays.toString(),
                                  context: context,
                                  isHalfScreen: true),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: trackController.userApplication.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.r)),
                                  elevation: 7,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "FullName",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: CommonText(
                                            textHint: trackController.userApplication[index].title.toString()+trackController.userApplication[index].firstName.toString() + " " +trackController.userApplication[index].lastName.toString(),
                                            context: context,
                                            isHalfScreen: false),
                                      ),
                                      SizedBox(height: 5.h,),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 10.w),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Nationality",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(height: 5.h),
                                                CommonText(
                                                    textHint: trackController.userApplication[index].country.toString(),
                                                    context: context,
                                                    isHalfScreen: true),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.h),
                                          Column(
                                            children: [
                                              Text(
                                                "Date of Travel",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(height: 5.h),
                                              CommonText(
                                                  textHint: DateFormat('dd-MM-yyyy').format(DateTime.parse(trackController.userApplication[index].date)),
                                                  context: context,
                                                  isHalfScreen: true),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      // Text(
                                      //   "Date of Travel",
                                      //   style: TextStyle(
                                      //       color: Colors.grey,
                                      //       fontSize: 18.sp,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 10.w, right: 10.w),
                                      //   child: CommonText(
                                      //       textHint: trackController.userApplication[index].date.toString(),
                                      //       context: context,
                                      //       isHalfScreen: false),
                                      // ),
                                      // SizedBox(
                                      //   height: 5.h,
                                      // ),
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5.h),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w,
                                            right: 10.w,
                                            bottom: 20.h),
                                        child: CommonText(
                                            textHint: trackController.trackApplicationModel.applicationData!.applicationStatus.toString()=="Waiting for Payment"?"New Application":trackController.trackApplicationModel.applicationData!.applicationStatus.toString(),
                                            context: context,
                                            isHalfScreen: false),
                                      ),
                                      trackController.trackApplicationModel.applicationData!.applicationStatus=="Approved"? Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w,
                                            bottom: 20.h,
                                            right: 10.w),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(downloadImage),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                           Text(
                                              "Visa",
                                              style: TextStyle(
                                                  color: colorYellow,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 35.w,
                                            ),
                                            Image.asset(downloadImage),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Insurance",
                                              style: TextStyle(
                                                  color: colorYellow,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ):Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ):Container(),
              ],
            ),),
        ),
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(()=>
            trackController.userApplication.length>0?
            trackController.trackApplicationModel.applicationData!.pay_status=="nopaid"?Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, bottom: 5.h, top: 5.h),
              child: Container(
                height: 35.h,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text(
                    "PAY NOW",
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: colorYellow,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ):SizedBox():SizedBox(),
            ),
            SizedBox(),
            CommonBottomNavigation()
          ],
        ),
      ),
    );
  }
}
