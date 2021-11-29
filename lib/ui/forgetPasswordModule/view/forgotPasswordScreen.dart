import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/forgetPasswordModule/controller/forgotPasswordController.dart';
import 'package:visa_app/ui/signInModule/view/signInScreen.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // put controller class instance inside here with help of a variable
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  // Node variables for initial check on textField on first tap
  FocusNode emailfocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Code for focus Node
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      emailfocus.addListener(() {
        controller.checkEmail(controller.emailController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: Image.asset(
                forgotImage,
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: colorWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(logo, height: 100.h, width: 100.h),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.3,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: Colors.white),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enter your email for the varification process",
                          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      CommonSignUpTextField(
                          context: context,
                          hintText: emailHintText,
                          maxLine: 1,
                          suffixIcon: Icons.email,
                          focusNode: emailfocus,
                          // binding Getx Controller to textField controller
                          controller: controller.emailController,
                          onChanged: (String email) {
                            // validation binding from controller class
                            controller.checkEmail(email);
                          },
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.name),
                      Obx(() => controller.emailError.value
                          ? Text(
                              controller.emailValidationMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container()),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(
                        () => InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            height: 35.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorYellow),
                            child: Center(
                              child: Text(
                                continueText,
                                style: TextStyle(
                                    fontSize: 14.sp, color: colorWhite),
                              ),
                            ),
                          ),
                          onTap: controller.isValidValidation.value
                              ? () async {
                            {
                              bool isOnline = await hasNetwork();
                              if(isOnline)  {
                                controller.forgotPasswordApi();
                              }
                              else{
                                Get.snackbar("oops..","Internet not avaliable");
                              }
                            }
                          }
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      RichText(
                        text: TextSpan(
                          style: (TextStyle(color: colorBlack)),
                          children: [
                            TextSpan(
                                text: continueLoginText,
                                style: TextStyle(color: colorBlack)),
                            TextSpan(
                              text: "  " + goBackText,
                              style: TextStyle(
                                  color: colorBlue,
                                  fontWeight: FontWeight.bold),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => Get.to(SignIn()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
