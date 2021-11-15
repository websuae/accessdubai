import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/FAQModule/view/FAQScreen.dart';
import 'package:visa_app/ui/chatWithUsModule/view/chatWithUsScreen.dart';
import 'package:visa_app/ui/contactUsModule/view/contactUsScreen.dart';
import 'package:visa_app/ui/howToApplyModule/view/howToApplyScreen.dart';
import 'package:visa_app/ui/signInModule/view/signInScreen.dart';
import 'package:visa_app/ui/typesOfVisaModule/view/typesOfVisaScreen.dart';
import 'package:visa_app/ui/whyUsModule/view/whyUsScreen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  String username ="";
  String email ="";
  bool isLogins =false;
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    username= prefs.getString(userName).toString();
    email= prefs.getString(userEmail).toString();
    if(prefs.containsKey(isLogin)) {
      isLogins = prefs.getBool(isLogin)!;
    }
  }

  void whatsAppOpen() async{
    var whatsapp ="+917623837736";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getBoolValuesSF();
      setState(() {

      });
      print("username value:" + username.toString());
      print("email value:" + email.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite,
        body: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      new_logo,
                      height: 80.h,
                      width: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isLogins?username:" " ,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                             Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text(
                                isLogins?email:" " ,overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(crossImage,
                        height: 15.h,
                        width: 15.h),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                drawerWidget("Home",Image.asset(homeImage), () {
                  Navigator.pop(context);
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Types of visa", Image.asset(drawerVisaImage), () {
                  Get.to(TypesOfVisaPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("How to apply", Image.asset(howToApplyImage,), () {
                  Get.to(HowToApplyPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("F.A.Q.", Image.asset(faqImage,), () {
                  Get.to(FAQPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Chat with us", Image.asset(chatWithUsImage,), () {
                 // Get.to(ChatWithUsPage());
                  whatsAppOpen();
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Contact us",Image.asset(contactUsBrownImage), () {
                  Get.to(ContactUsPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Privacy Policy",Image.asset(privacyPolicyImage,), () {
                  Get.to(ContactUsPage());
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                drawerWidget("Why US", Image.asset(whyUs,color: Colors.grey,height: 16.h,width: 16.h,),() {
                  Get.to(WhyUsPage());
                }),
                Spacer(),
                drawerWidget(isLogins?"Logout":"Login", Image.asset(logoutImage,), () async {
                  print("Logout:"+isLogins.toString());
                  if(!isLogins){
                    print("if call");
                    Get.offAll(SignIn());
                  }
                  else{
                    print("else call");
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Get.offAll((SignIn()));
                  }
                }),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey,
                    height: 0.5.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget drawerWidget(String text, Image image, Function() onClick) {
  return Padding(
    padding: EdgeInsets.all(5.h),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            onClick();
          },
          child: Row(
            children: [
              image,
              SizedBox(
                width: 10.w,
              ),
              Text(
                text
              ),
              Spacer(),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ],
    ),
  );
}
