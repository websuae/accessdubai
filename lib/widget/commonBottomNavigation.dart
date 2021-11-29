import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/ui/FAQModule/view/FAQScreen.dart';
import 'package:visa_app/ui/contactUsModule/view/contactUsScreen.dart';
import 'package:visa_app/ui/howToApplyModule/view/howToApplyScreen.dart';
import 'package:visa_app/ui/trackApplicationModule/view/trackApplicationScreen.dart';
import 'package:visa_app/ui/typesOfVisaModule/view/typesOfVisaScreen.dart';

class CommonBottomNavigation extends StatefulWidget {
  const CommonBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CommonBottomNavigation> createState() => _CommonBottomNavigationState();
}

class _CommonBottomNavigationState extends State<CommonBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (TypesOfVisaPage())));
              },
              child: Image.asset(
                visaImage,
                height: 25.h,
                width: 60.w,
                color: Color(0xff0176DA),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (TypesOfVisaPage())));
              },
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (HowToApplyPage())));
                },
                child: Image.asset(
                  howToApplyImage,
                  height: 25.h,
                  width: 60.w,
                  color: Color(0xff0176DA),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (TrackApplicationPage(applicationNumber: "",))));
              },
              child: Image.asset(
                trackApplicationImage,
                height: 40.h,
                width: 60.w,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => (FAQPage())));
              },
              child: Image.asset(
                faqImage,
                height: 25.h,
                width: 60.w,
                color: Color(0xff0176DA),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => (ContactUsPage())),
                );
              },
              child: Image.asset(
                contactUsBrownImage,
                height: 25.h,
                width: 60.w,
                color: Color(0xff0176DA),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 22.h,
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
              height: 22.h,
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
              height: 22.h,
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
              height: 22.h,
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
              height: 22.h,
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
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
