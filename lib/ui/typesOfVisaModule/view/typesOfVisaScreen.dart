import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/typesOfVisaModule/controller/typesOfVisaController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonBottomNavigation.dart';



class TypesOfVisaPage extends StatefulWidget {
  const TypesOfVisaPage({Key? key}) : super(key: key);

  @override
  _TypesOfVisaPageState createState() => _TypesOfVisaPageState();
}

class _TypesOfVisaPageState extends State<TypesOfVisaPage> {
  // bool descTextShowFlag = false;

  TypesOfVisaController controller = Get.put(TypesOfVisaController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool isOnline = await hasNetwork();
      if(isOnline)  {
        controller.typesOfVisaApi();
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
          body:
          SingleChildScrollView(
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
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "Type of visa",
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
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: Obx(
                        () => controller.visaTypeList != null &&
                                controller.visaTypeList.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.visaTypeList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image.network(
                                              controller.abc.imagePath! +
                                                  controller.visaTypeList[index]
                                                      .visatypeImg
                                                      .toString(),
                                              height: 150.h,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            controller.visaTypeList[index]
                                                .visatypeName
                                                .toString(),
                                            style: TextStyle(
                                                color: colorBlue,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 10.h,
                                               ),
                                            child:
                                            Html(
                                              data: controller
                                                  .visaTypeList[index]
                                                  .visatypeDesc
                                                  .toString(),
                                              style: {
                                                '#': Style(
                                                  fontSize: FontSize(18),
                                                  maxLines: controller
                                                      .visaTypeList[index]
                                                      .descTextShowFlag
                                                      ? 35
                                                      : 3,
                                                  textOverflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              },
                                            ),
                                            // Text(
                                            //   controller.visaTypeList[index]
                                            //       .visatypeDesc
                                            //       .toString(),
                                            //   maxLines:
                                            //   controller.visaTypeList[index].descTextShowFlag ? 35 : 3,
                                            //   textAlign: TextAlign.center,
                                            //   style: TextStyle(
                                            //       color: colorBlack,
                                            //       fontSize: 16.sp,
                                            //       fontWeight:
                                            //           FontWeight.normal),
                                            // ),
                                          ),



                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i <
                                                        controller.visaTypeList
                                                            .length;
                                                    i++) {
                                                  if (i == index) {
                                                    controller.visaTypeList[index].descTextShowFlag =
                                                    !controller.visaTypeList[index].descTextShowFlag;
                                                  }
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.w, ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  controller.visaTypeList[index].descTextShowFlag
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.h,
                                                                  bottom: 40.h),
                                                          child: Container(
                                                            height: 30.h,
                                                            width: 140.w,
                                                            color:
                                                                colorLightGrey,
                                                            child: Center(
                                                              child: Text(
                                                                "Show Less ->",
                                                                style: TextStyle(
                                                                    color:
                                                                        colorBlue,
                                                                    fontSize:
                                                                        16.sp),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.h,
                                                                  bottom: 40.h),
                                                          child: Container(
                                                            height: 30.h,
                                                            width: 140.w,
                                                            color:
                                                                colorLightGrey,
                                                            child: Center(
                                                              child: Text(
                                                                "Read More ->",
                                                                style: TextStyle(
                                                                    color:
                                                                        colorBlue,
                                                                    fontSize:
                                                                        16.sp),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            :controller.loader.value?Center(child: CircularProgressIndicator()):Container()),
                      ),

                ],
              ),
            ),
          ),
          bottomNavigationBar: CommonBottomNavigation()),
    );
  }
}

// class SelectIndex {
//   String? value;
//   String? image;
//   String? value2;
//   bool? isSelected;
//
//   SelectIndex({this.value, this.image, this.value2, this.isSelected});
// }
