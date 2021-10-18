import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/HomeModule/view/homeScreen.dart';
import 'package:visa_app/ui/forgetPasswordModule/view/forgotPasswordScreen.dart';
import 'package:visa_app/ui/signInModule/controller/signInController.dart';
import 'package:visa_app/ui/signUpModule/view/signUpScreen.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // put controller class instance inside here with help of a variable
  SignInController controller = Get.put(SignInController());

  // Node variables for initial check on textField on first tap
  FocusNode emailfocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // Code for focus Node
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      emailfocus.addListener(() {
        controller.checkEmail(controller.emailController.text);
      });

      passwordFocus.addListener(() {
        controller.checkPassword(controller.passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(
            () => !controller.loader.value
                ? Stack(
                    children: [
                      Container(
                        child: Image.asset(
                          signinImage,
                          height: MediaQuery.of(context).size.height / 1.7,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Text(
                              "Skip",
                              style: TextStyle(fontSize: 16.sp, color: colorWhite),
                            ),
                            onTap: () => Get.offAll(HomePage()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 20.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            signInText,
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30)),
                              color: Colors.white),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                            child: Column(
                              children: [
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
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.name),
                                Obx(() => controller.emailError.value
                                    ? Text(
                                        controller.emailValidationMessage.value,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Container()),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CommonSignUpTextField(
                                    context: context,
                                    hintText: passwordHintText,
                                    maxLine: 1,
                                    suffixIcon: Icons.visibility_off,
                                    focusNode: passwordFocus,
                                    onChanged: (String password) {
                                      // validation binding from controller class
                                      controller.checkPassword(password);
                                    },
                                    // binding Getx Controller to textField controller
                                    controller: controller.passwordController,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text),
                                Obx(() => controller.passError.value
                                    ? Text(
                                        controller
                                            .passwordValidationMessage.value,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Container()),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        forgotPasswordText,
                                        style: TextStyle(color: colorBlue),
                                      ),
                                      onTap: () {
                                        Get.to(ForgotPassword());
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Obx(
                                  () => InkWell(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      height: 35.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: colorYellow),
                                      child: Center(
                                        child: Text(
                                          signInText,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: colorWhite),
                                        ),
                                      ),
                                    ),
                                    onTap: controller.isValidValidation.value
                                        ? () {
                                            controller.loader.value = true;
                                            controller.doLoginApi();
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
                                          text: donotHaveAnAccountText,
                                          style: TextStyle(color: colorBlack)),
                                      TextSpan(
                                        text: "  " + signUpText,
                                        style: TextStyle(
                                            color: colorBlue,
                                            fontWeight: FontWeight.bold),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () => Get.offAll(SignUp()),
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
                  )
                : Center(child: Container(child: CircularProgressIndicator())),
          )),
    );
  }
}
