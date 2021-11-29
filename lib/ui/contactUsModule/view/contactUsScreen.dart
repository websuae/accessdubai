import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/ui/contactUsModule/controller/contactUsController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  ContactUsController controller = Get.put(ContactUsController());
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  FocusNode mobileFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      nameFocus.addListener(() {
        controller.checkName(controller.nameController.text);
      });
      emailFocus.addListener(() {
        controller.checkEmail(controller.emailController.text);
      });

      mobileFocus.addListener(() {
        controller.checkMobile(controller.mobileController.text);
      });
      messageFocus.addListener(() {
        controller.checkMessage(controller.messageController.text);
      });
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
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                      child: Image.asset(
                    contactUsSupportImage,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    height: 170.h,
                  )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h, left: 100.h),
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
                          controller: controller.nameController,
                          focusNode: nameFocus,
                          onChanged: (String name) {
                            controller.checkName(name);
                          },
                          isDivider: false,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next),
                      Obx(() => controller.nameError.value
                          ? Text(
                              controller.nameValidationMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(height: 10.h)),
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
                                border:
                                    Border.all(color: Colors.grey.shade300)),
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
                                controller: controller.mobileController,
                                focusNode: mobileFocus,
                                onChanged: (String mobile) {
                                  controller.checkMobile(mobile);
                                },
                                maxLine: 1,
                                isDivider: false,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next),
                          ),
                        ],
                      ),
                      Obx(() => controller.mobileError.value
                          ? Text(
                              controller.mobileValidationMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(height: 10.h)),
                      SizedBox(height: 10.h),
                      Text("Email"),
                      SizedBox(height: 10.h),
                      CommonSignUpTextField(
                          context: context,
                          hintText: "",
                          maxLine: 1,
                          controller: controller.emailController,
                          isDivider: false,
                          onChanged: (String email) {
                            controller.checkEmail(email);
                          },
                          focusNode: emailFocus,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next),
                      Obx(() => controller.emailError.value
                          ? Text(
                              controller.emailValidationMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(height: 10.h)),
                      SizedBox(height: 10.h),
                      Text("Message"),
                      SizedBox(height: 10.h),
                      CommonSignUpTextField(
                          context: context,
                          hintText: "",
                          height: 50.h,
                          maxLine: 10,
                          focusNode: messageFocus,
                          onChanged: (String message) {
                            controller.checkMessage(message);
                          },
                          controller: controller.messageController,
                          isDivider: false,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.newline),
                      Obx(() => controller.messageError.value
                          ? Text(
                              controller.messageValidationMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(height: 10.h)),
                      SizedBox(height: 20.h),
                      Container(
                        height: 35.h,
                        width: MediaQuery.of(context).size.width,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: controller.isValidValidation.value ? () async{
                              bool isOnline = await hasNetwork();
                              if(isOnline)  {
                                controller.loader.value = true;
                                controller.contactUsApi();
                              }
                              else{
                                Get.snackbar("oops..","Internet not avaliable");
                              }
                             }
                                : null,
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
