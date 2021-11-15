import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/model/Nationality.dart';
import 'package:visa_app/ui/signInModule/view/signInScreen.dart';
import 'package:visa_app/ui/signUpModule/controller/signUpController.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // put controller class instance inside here with help of a variable
  SignUpController controller = Get.put(SignUpController());

  // Node variables for initial check on textField on first tap
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode nationalityFocus = FocusNode();


  List<dynamic> info = [];



  @override
  void initState() {
    super.initState();
    // Code for focus Node
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      nameFocus.addListener(() {
        controller.checkName(controller.nameController.text);
      });
      emailFocus.addListener(() {
        controller.checkEmail(controller.emailController.text);
      });
      passwordFocus.addListener(() {
        controller.checkPassword(controller.passwordController.text);
      });
      mobileFocus.addListener(() {
        controller.checkMobile(controller.mobileController.text);
      });
      nationalityFocus.addListener(() {
        controller.checkNationality(controller.countryDropDownName.value);
      });
    });
  }

  Future<List<Nationality>> ReadJsonData() async {
    //read json file
    final jsondata =
        await rootBundle.rootBundle.loadString('json/country.json');
    //decode json data as list
    info = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return info.map((e) => Nationality.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => !controller.loader.value
                  ? Container(
                      color: colorWhite,
                      child: signUp(),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget signUp() {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            forgotImage,
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 23.h),
          child: InkWell(
            onTap: () =>  Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, color: colorWhite)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40.w, top: 20.h),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              signUpText,
              style: TextStyle(
                  color: colorWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.sp),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: colorWhite,
            ),
            padding: EdgeInsets.all(10.h),
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CommonSignUpTextField(
                    context: context,
                    hintText: nameHintText,
                    maxLine: 1,
                    suffixIcon: Icons.person,
                    focusNode: nameFocus,
                    onChanged: (String name) {
                      controller.checkName(name);
                    },
                    controller: controller.nameController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name),
                Obx(() => controller.nameError.value
                    ? Text(
                        controller.nameValidationMessage.value,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(
                  height: 10.h
                )),
                // SizedBox(
                //   height: 10.h,
                // ),
                CommonSignUpTextField(
                  context: context,
                  hintText: emailHintText,
                  maxLine: 1,
                  suffixIcon: Icons.email,
                  focusNode: emailFocus,
                  onChanged: (String email) {
                    controller.checkEmail(email);
                  },
                  controller: controller.emailController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
                Obx(() => controller.emailError.value
                    ? Text(
                        controller.emailValidationMessage.value,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container( height: 10.h)),
                // SizedBox(
                //   height: 10.h,
                // ),
                CommonSignUpTextField(
                    context: context,
                    hintText: referralHintText,
                    maxLine: 1,
                    suffixIcon: Icons.group,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Container(
                      height: 37.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300)),
                      child: CountryCodePicker(
                        //onChanged: print,
                        onChanged: (c) {
                          controller.countryCode=c.dialCode.toString();
                         print("c.code::"+c.dialCode.toString()) ;
                        },
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
                          hintText: mobileHintText,
                          maxLine: 1,
                          suffixIcon: Icons.call,
                          controller: controller.mobileController,
                          focusNode: mobileFocus,
                          onChanged: (String mobile) {
                            controller.checkMobile(mobile);
                          },
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number),
                    ),
                  ],
                ),
                Obx(() => controller.mobileError.value
                    ? Text(
                        controller.mobileValidationMessage.value,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(height: 10.h)),
                // SizedBox(height: 10.h),
                CommonSignUpTextField(
                    context: context,
                    hintText: passwordHintText,
                    maxLine: 1,
                    suffixIcon: Icons.visibility_off,
                    focusNode: passwordFocus,
                    onChanged: (String password) {
                      controller.checkPassword(password);
                    },
                    controller: controller.passwordController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name),
                Obx(() => controller.passError.value
                    ? Text(
                        controller.passwordValidationMessage.value,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(height: 10.h)),
                // SizedBox(
                //   height: 10.h,
                // ),
                FutureBuilder(
                    future: ReadJsonData(),
                    builder: (context, data) {
                      if (data.hasError) {
                        //in case if error found
                        return Center(child: Text("${data.error}"));
                      } else if (data.hasData) {
                        var items = data.data as List<Nationality>;
                        return Container(
                          padding: EdgeInsets.only(left: 5.w),
                          height: 38.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              isExpanded: true,
                              focusNode: nationalityFocus,
                              iconEnabledColor: colorBlue,
                              iconSize: 35,
                              hint: Obx(
                                () => controller.countryDropDownName.value == ""
                                    ? Text('Nationality')
                                    : Padding(
                                        padding: EdgeInsets.only(left: 9.w),
                                        child: Text(
                                          controller.countryDropDownName.value,
                                          style: TextStyle(color: colorBlack),
                                        ),
                                      ),
                              ),
                              items: items.map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(
                                    value.name.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                //   setState(() {
                                controller.countryDropDownName.value =
                                    value.toString();
                                controller.checkNationality(
                                    controller.countryDropDownName.value);
                                //  });
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.red,
                        );
                      }
                    }),
                Obx(() => controller.nationError.value
                    ? Text(
                        controller.nationValidationMessage.value,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(height: 10.h)),
                // SizedBox(
                //   height: 10.h,
                // ),
                SizedBox(
                  height: 30.h,
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
                          signUpText,
                          style: TextStyle(fontSize: 14.sp, color: colorWhite),
                        ),
                      ),
                    ),
                    onTap: controller.isValidValidation.value
                        ? () {
                            controller.loader.value = true;
                            controller.doSignUpApi();
                          }
                        : null,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                RichText(
                  text: TextSpan(
                    style: (TextStyle(color: colorBlack)),
                    children: [
                      TextSpan(
                          text: "Already a member?",
                          style: TextStyle(color: colorBlack)),
                      TextSpan(
                        text: "  " + "Sign In",
                        style: TextStyle(
                            color: colorBlue, fontWeight: FontWeight.bold),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Get.offAll(SignIn()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
