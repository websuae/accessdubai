import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/whyUsModule/controller/whyUsController.dart';
import 'package:visa_app/widget/commonAppBar.dart';

class WhyUsPage extends StatefulWidget {
  @override
  _WhyUsPageState createState() => _WhyUsPageState();
}

class _WhyUsPageState extends State<WhyUsPage> {
  List<WhyUsList> whyUSList = <WhyUsList>[];

  bool descTextShowFlag = false;
  WhyUsController controller = Get.put(WhyUsController());

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // WebView.platform = SurfaceAndroidWebView();
    whyUSList.add(WhyUsList(
        image: whyUsFirstImage,
        title: "Experienced & Trusted",
        description:
            "Legacy speaks for itself. Our comprehensive Travel related services include UAE Visa application, Airline tickets, Hotel bookings, Transfers, Holiday Packages, Sightseeing and Activities, and ancillary services."));
    whyUSList.add(WhyUsList(
        image: whyUsSecondImage,
        title: "Reliable Visa Assistance",
        description:
            "To make all our clients have a smooth and enjoyable experience with us, customer service is accessible round the clock, we are available 24/7 on LIVE chat."));
    whyUSList.add(WhyUsList(
        image: whyUsThirdImage,
        title: "Safety & Security",
        description:
            "Your visa application will be treated with strictest confidence and all your personal and professional documents are safe with us."));
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool isOnline = await hasNetwork();
      if(isOnline)  {
        controller.whyUsApi();
      }
      else{
        Get.snackbar("oops..","Internet not avaliable");
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
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
        child:
      Container(
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
                              width:
                              MediaQuery.of(context).size.width,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Text(
                        "Why Us",
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
          Obx(()=>controller.loader.value?Center(child: CircularProgressIndicator()):
          controller.whyUsResponse != null && controller.whyUsResponse.data != null? SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 10.h),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'We Are ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorYellow,
                                      fontSize: 25.sp)),
                              TextSpan(
                                  text: 'Dusk Travel And \ntourism',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorBlue,
                                      fontSize: 25.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: whyUSList.length,
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 5.w),
                                child: Image.asset(
                                    whyUSList[index].image.toString()),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  whyUSList[index].title.toString(),
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, top: 2.h),
                                  child: Container(
                                      width: 30.w,
                                      height: 1.h,
                                      color: colorYellow)),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                    whyUSList[index].description.toString()),
                              )
                            ]);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 10.h),
                        child: Text(
                          "Why choose us for \nyour UAE visa application",
                          style: TextStyle(
                              color: colorBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h, top: 15.h),
                        child:
                        Html(
                          data: controller.whyUsResponse.data![0].pageContent.toString()
                              .toString(),
                          style: {
                            '#': Style(
                              fontSize: FontSize(18),
                              maxLines: descTextShowFlag
                                  ? 35
                                  : 3,
                              textOverflow:
                              TextOverflow.ellipsis,
                            ),
                          },
                        ),

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag = !descTextShowFlag;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            descTextShowFlag
                                ? Text(
                                    "Show Less..",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text("Show More..",
                                    style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 150.h,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                        ),
                        items: [whyUsBigImage, signinImage].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.asset(
                                      "$i",
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fitWidth,
                                      height: 150.h,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorLightGrey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xff0DB9B6),
                                  ),
                                  Text(
                                    "Our Showroom Location",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: colorBlack),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 200,
                              child: PageView(
                                controller: PageController(viewportFraction: 0.8),
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                children: [
                                  Image.asset(whyUsBigImage),
                                  Image.asset(whyUsBigImage),
                                  Image.asset(whyUsBigImage),
                                ],
                              ),
                            ),
                            // ListView.builder(
                            //     itemCount: 4,
                            //     scrollDirection: Axis.horizontal,
                            //     physics: NeverScrollableScrollPhysics(),
                            //
                            //     itemBuilder: (context, index) {
                            //       return Container(
                            //         child: Image.asset(whyUsBigImage),
                            //       );
                            //     },
                            //     shrinkWrap: true )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ):Container(),)
            ],
          ),
        )
      ),
    ),
        // WebView(
        //   javascriptMode: JavascriptMode.unrestricted,
        //   initialUrl: 'https://accessdubai.dusktours.com/about-us',
        // ),
        );
  }
}

class WhyUsList {
  String? image;
  String? title;
  String? description;

  WhyUsList({this.image, this.title, this.description});
}
