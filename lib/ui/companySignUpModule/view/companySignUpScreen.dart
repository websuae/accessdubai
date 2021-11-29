import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/ui/HomeModule/view/homeScreen.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class CompanySignUp extends StatefulWidget {
  const CompanySignUp({Key? key}) : super(key: key);

  @override
  State<CompanySignUp> createState() => _CompanySignUpState();
}

class _CompanySignUpState extends State<CompanySignUp> {
  // variable for file pick operation
  var picked;

  String? _dropDownValue = "+91";
  String? _countryDropDownName = "UAE";
  List<String> countryNameList = <String>[
    "UAE",
    "India",
    "Canada",
    "Australia",
    "USA",
    "Japan"
  ];

  var strNoFileChose = "No File chosen";

  // Node variables for initial check on textField on first tap
  FocusNode companyTitleFocus = FocusNode();
  FocusNode companyEmailFocus = FocusNode();
  FocusNode companyPasswordFocus = FocusNode();
  FocusNode companyMobileFocus = FocusNode();
  FocusNode companyContactPersonFocus = FocusNode();
  FocusNode companyDesignationFocus = FocusNode();
  FocusNode companyLicenseNumberFocus = FocusNode();
  FocusNode companyYearOfRegistrationFocus = FocusNode();
  FocusNode companyAddressFocus = FocusNode();
  FocusNode companyMessageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            CommonSignUpTextField(
                context: context,
                hintText: companyTitleHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: companyNameHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w),
              height: 38.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: colorBlue)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  isExpanded: true,
                  hint: _countryDropDownName == null
                      ? Text('Dropdown')
                      : Text(
                          _countryDropDownName!,
                          style: TextStyle(color: colorBlack),
                        ),
                  items: countryNameList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _countryDropDownName = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: contactPersonNameHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name),
            SizedBox(height: 10.h),
            CommonSignUpTextField(
                context: context,
                hintText: designationHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: mobileHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: emailHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: licenseNumberHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: yearOfRegistrationHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: addressHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: passwordHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: messageHintText,
                maxLine: 1,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: colorBlue)),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      picked = await FilePicker.platform.pickFiles();
                      if (picked == null) {
                        Center(child: CircularProgressIndicator());
                      } else {
                        print(picked.files.first.name != null &&
                                picked.files.first.name != ""
                            ? picked.files.first.name
                            : "");
                        setState(() {
                          strNoFileChose = picked.files.first.name;
                        });
                      }
                    },
                    child: Text(
                      "Upload Taade license",
                      style: TextStyle(color: Colors.black54),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child:
                        Text(strNoFileChose, style: TextStyle(fontSize: 14.sp)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonSignUpTextField(
                context: context,
                hintText: captchaHintText,
                maxLine: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: colorYellow),
                child: Center(
                  child: Text(
                    signUpText,
                    style: TextStyle(fontSize: 14.sp, color: colorWhite),
                  ),
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
            ),
          ],
        ),
      ),
    );
  }
}
