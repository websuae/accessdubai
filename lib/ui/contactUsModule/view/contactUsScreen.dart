import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

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
          child: Column(
            children: [
              Stack(
                children: [
                  Center(child: Image.asset(contactUsSupportImage,width: MediaQuery.of(context).size.width,fit: BoxFit.fill, height: 170.h,)),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h,left: 100.h),
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: colorWhite),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                color: colorWhite,
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Get In Touch",
                        style: TextStyle(
                            color: colorBlue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Text("name"),
                      SizedBox(height: 10.h),
                      CommonSignUpTextField(
                          context: context,
                          hintText: "",
                          maxLine: 1,
                          isDivider: false,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next),
                      SizedBox(height: 10.h),
                      Text("Number"),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            height: 37.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300)),
                            child: CountryCodePicker(
                              onChanged: print,
                              initialSelection: '+971',
                              favorite: ['+971'],
                              flagWidth: 20,
                              padding: EdgeInsets.zero,
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: CommonSignUpTextField(
                                context: context,
                                hintText: "00000 00000",
                                maxLine: 1,
                                isDivider: false,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text("Email"),
                      SizedBox(height: 10.h),
                      CommonSignUpTextField(
                          context: context,
                          hintText: "",
                          maxLine: 1,
                          isDivider: false,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next),
                      SizedBox(height: 10.h),
                      Text("Message"),
                      SizedBox(height: 10.h),
                      CommonSignUpTextField(
                          context: context,
                          hintText: "",
                          height: 50.h,
                          maxLine: 10,
                          isDivider: false,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.newline),
                      SizedBox(
                        height: 20.h
                      ),
                      Container(
                        height: 35.h,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                            });
                          },
                          child: Text(
                            "Send Message",
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
