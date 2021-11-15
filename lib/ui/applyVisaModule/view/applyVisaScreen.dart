import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/model/Nationality.dart';
import 'package:visa_app/ui/HomeModule/model/countryModel.dart';
import 'package:visa_app/ui/applyVisaModule/controller/applyVisaController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class ApplyVisaPage extends StatefulWidget {
  String visatypeId;
  String visatypeTitle;

  ApplyVisaPage(
      {required this.visatypeId, required this.visatypeTitle, Key? key});

  @override
  State<ApplyVisaPage> createState() => _ApplyVisaPageState();
}

class _ApplyVisaPageState extends State<ApplyVisaPage> {
  var picked;
  ApplyVisaController controller = Get.put(ApplyVisaController());

  List<SelectIndex> applyVisaNumberList = <SelectIndex>[];
  int lastIndex = 0;
  DateTime currentDate = DateTime.now();

  String? _countryDropDownName = "Title";
  List<String> countryNameList = <String>["Mr.", "Mrs.", "Miss"];

  // var strNoFileChose = "Colored Passport";
  // // late FilePickerResult path1;
  //
  // var strNoFileChose1 = "Colored Passport";
  // late FilePickerResult path2 ;

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode nationalityFocus = FocusNode();

  String selectedCountryId = "";

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    controller.userIds = prefs.getString(userId).toString();
  }

  @override
  void initState() {
    controller.getCountryListApi();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getBoolValuesSF();
      setState(() {});

      print("username value:" + controller.userIds.toString());
    });
    super.initState();
    print("visa plan id:" + widget.visatypeId);
    var parts = widget.visatypeTitle.split(' ');
    //30-30
    //30 multiple - 30days_multiple
    //30 express - 30days_express

    //controller.prefix = parts[0].trim();
    if (parts[2].trim().toLowerCase() == "single") {
      controller.prefix = parts[0].trim();
    } else if (parts[2].trim().toLowerCase() == "multiple") {
      controller.prefix = parts[0].trim() + "days_multiple";
    } else if (parts[2].trim().toLowerCase() == "express") {
      controller.prefix = parts[0].trim() + "days_express";
    }
    print("prefix:" + controller.prefix);

    //Adding 10 items to the list
    for (int i = 1; i <= 10; i++) {
      applyVisaNumberList
          .add(SelectIndex(value: i.toString(), isSelected: false));
    }

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      firstNameFocus.addListener(() {
        controller.checkName(controller.firstNameController.text);
      });

      lastNameFocus.addListener(() {
        controller.checkName(controller.lastNameController.text);
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
        body: Obx(
          () => controller.loader.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                                  autoPlayInterval:
                                      Duration(milliseconds: 1500),
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
                                  "UAE VISA apply \nonline",
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
                          height: 5.h,
                        ),
                        Text(
                          widget.visatypeTitle,
                          style: TextStyle(
                              color: colorBlue,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Number of Application",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                              height: 90.h,
                              width: 240.w,
                              child: GridView.count(
                                // crossAxisCount is the number of items
                                crossAxisCount: 5,
                                physics: NeverScrollableScrollPhysics(),
                                // This creates two columns with two items in each column
                                children: List.generate(
                                    applyVisaNumberList.length, (index) {
                                  return visaPageCounter(
                                      applyVisaNumberList,
                                      applyVisaNumberList[index]
                                          .value
                                          .toString(),
                                      index,
                                      true);
                                }),
                              )),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.dynamicList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return visaFormContainer(index);
                            })
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: controller.childWidgetLength.value > 0
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                            value: controller.isChecked.value,
                            onChanged: (bool) {
                              controller.isChecked.value =
                                  !controller.isChecked.value;
                            }),
                      ),
                      Text(
                        "I Accept Terms and Condition",
                        style: TextStyle(color: colorYellow, fontSize: 15.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                    child: Container(
                      height: 35.h,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          print("applyVisaNumberList length:" +
                              controller.dynamicList.length.toString());
                          // Navigator.push(
                          //  context,
                          //  MaterialPageRoute(
                          //      builder: (context) =>
                          //          (TrackApplicationPage())));
                          if (controller.dynamicList.length > 0) {
                            if(controller.dynamicList[0].CountryId != "") {
                              controller.doApplyVisa(
                                  controller.prefix,
                                  controller.dynamicList.length,
                                  int.parse(controller.userIds),
                                  controller.dynamicList[0].title.toString(),
                                  controller.dynamicList[0].firstName
                                      .toString(),
                                  controller.dynamicList[0].lastName.toString(),
                                  controller.dynamicList[0].CountryName
                                      .toString(),
                                  int.parse(controller.dynamicList[0].CountryId
                                      .toString()),
                                  controller.dateController.text.toString(),

                                  controller.dynamicList[0].visapathPassportSizePhoto!.paths
                                      .first
                                      .toString(),

                                controller.dynamicList[0].CountryName=="India"?""
                                    :controller.dynamicList[0].visapathColoredPassport!.paths
                                    .first
                                    .toString(),


                                controller.dynamicList[0].CountryName=="India"?
                                controller.dynamicList[0].visapathIndiaFirst!.paths.first
                                    .toString():"",


                                controller.dynamicList[0].CountryName=="India"?
                                controller.dynamicList[0].visapathIndiaLast!.paths.first
                                    .toString():"",


                                controller.dynamicList[0].CountryName=="Pakistan"?
                                controller.dynamicList[0].visapathPakistanFront!.paths
                                      .first
                                      .toString():"",


                                controller.dynamicList[0].CountryName=="Pakistan"?
                                controller.dynamicList[0].visapathPakistanBack!.paths
                                    .first
                                    .toString():"",);
                            }
                            else{
                              Get.snackbar("Alert..", "Please select country");
                            }
                          } else {
                            Get.snackbar("Alert", "Must apply for 1 visa");
                          }
                          // for(int i=0;i<controller.dynamicList.length;i++)
                          //   {
                          //   controller.doApplyVisa(30,
                          //       controller.dynamicList.length,
                          //      int.parse(userIds),
                          //       controller.dynamicList[i].title.toString(),
                          //       controller.dynamicList[i].firstName.toString(),
                          //       controller.dynamicList[i].lastName.toString(),
                          //       controller.dynamicList[i].CountryName.toString(),
                          //      int.parse(controller.dynamicList[i].CountryId.toString()),
                          //      controller.dateController.text.toString(),
                          //      "",
                          //      "",
                          //      "",
                          //      "",
                          //      "",
                          //      "");
                          //   }
                          /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        (TrackApplicationPage())));*/
                        },
                        child: Text(
                          "PROCEED",
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
              )
            : SizedBox(),
      ),
    );
  }

  Widget visaPageCounter(List<SelectIndex> applyVisaNumber, String text,
      int index, bool isFisrst) {
    return Column(
      children: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  child: Container(
                    width: 35.h,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: applyVisaNumber[index].isSelected!
                          ? colorBlue
                          : Colors.grey.shade200,
                      border:
                          Border.all(color: Colors.grey.shade400, width: 2.h),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.h, right: 8.h),
                      child: Center(
                        child: Text(text,
                            textAlign: TextAlign.center,
                            style: applyVisaNumber[index].isSelected!
                                ? TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)
                                : TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      print("index:" + index.toString());

                      for (int i = 0; i < applyVisaNumber.length; i++) {
                        if (i == index) {
                          controller.childWidgetLength.value =
                              int.parse(applyVisaNumber[i].value!);
                          applyVisaNumber[i].isSelected = true;
                          controller.dynamicList.clear();
                          for (int a = 0;
                              a < controller.childWidgetLength.value;
                              a++) {
                            controller.dynamicList.add(VisaValue(
                                title: "",
                                firstName: "",
                                lastName: "",
                                CountryId: "",
                                CountryName: "",
                                travelDate: "",
                                imageColoredPassport: "Colored Passport",
                                imagePassportSizePhoto: "Passport Size Photo",
                                imageIndiaFirst: "Colored Passport(First Page)",
                                imageIndiaLast: "Colored Passport(Last Page)",
                                imagePakistanFront: "Pakistan National ID(Front)",
                                imagePakistanBack: "Pakistan National ID(Back)",
                                visapathColoredPassport: null,
                                visapathPassportSizePhoto: null,
                                visapathIndiaFirst: null,
                                visapathIndiaLast: null,
                                visapathPakistanFront: null,
                                visapathPakistanBack: null));
                          }
                          print(
                              "i:" + controller.dynamicList.length.toString());
                        } else {
                          applyVisaNumber[i].isSelected = false;
                        }
                      }
                    });
                  }),
              SizedBox(
                width: 5.w,
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        controller.dateController.text =
            DateFormat('dd-MM-yyyy').format(currentDate);
        //dynamicList[index].travelDate=DateFormat('dd-MM-yyyy').format(currentDate);
      });
  }

  Widget visaFormContainer(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 10.h),
      child: Column(
        children: [
          Container(
            height: 25.h,
            child: DropdownButton<String>(
              isDense: true,
              isExpanded: true,
              iconEnabledColor: colorBlack,
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              hint: controller.dynamicList[index].title == ""
                  ? Text('Title')
                  : Text(
                      controller.dynamicList[index].title!,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
              items: countryNameList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  print("value:" + value.toString());
                  controller.dynamicList[index].title = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CommonSignUpTextField(
              context: context,
              hintText: firstNameHintText,
              maxLine: 1,
              isDivider: false,
              //focusNode: firstNameFocus,
              onChanged: (String firstName) {
                // validation binding from controller class
                // controller.checkName(password);
                controller.dynamicList[index].firstName = firstName.toString();
              },
              // binding Getx Controller to textField controller
              // controller: controller.firstNameController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text),
          Obx(
            () => controller.firstNameError.value
                ? Text(
                    controller.firstNameValidationMessage.value,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
          ),
          CommonSignUpTextField(
              context: context,
              hintText: lastNameHintText,
              maxLine: 1,
              isDivider: false,
              //focusNode: lastNameFocus,
              onChanged: (String lastName) {
                // validation binding from controller class
                //  controller.checkName(password);
                controller.dynamicList[index].lastName = lastName.toString();
              },
              // binding Getx Controller to textField controller
              // controller: controller.lastNameController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text),
          Obx(
            () => controller.lastNameError.value
                ? Text(
                    controller.lastNameValidationMessage.value,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
          ),
          FutureBuilder(
              future: ReadJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  //in case if error found
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  var items = data.data as List<Nationality>;
                  return Container(
                      height: 25.h,
                      child: DropdownButton<Country>(
                        isDense: true,
                        isExpanded: true,
                        focusNode: nationalityFocus,
                        iconEnabledColor: colorBlue,
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                        hint:
                            // Obx(
                            //       () =>
                            controller.dynamicList[index].CountryName == ""
                                ? Text('Nationality',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold))
                                : Text(
                                    controller.dynamicList[index].CountryName
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                        // ),
                        items: controller.countryList.map((value) {
                          return DropdownMenuItem<Country>(
                            value: value,
                            child: Text(
                              value.countryName.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          Country countryName;
                          countryName = value as Country;
                          setState(() {
                            controller.dynamicList[index].CountryName =
                                countryName.countryName.toString();
                            controller.dynamicList[index].CountryId =
                                countryName.countryId.toString();
                          });
                        },
                      )

                      );
                } else {
                  return Container(
                    color: Colors.red,
                  );
                }
              }),
          SizedBox(
            height: 10.h,
          ),
          CommonSignUpTextField(
              context: context,
              hintText: dateHintText,
              maxLine: 1,
              isDivider: false,
              onTap: () {
                FocusScope.of(context).unfocus();
                _selectDate(context, index);
              },
              isShowCursor: false,
              // binding Getx Controller to textField controller
              controller: controller.dateController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.datetime),
          Obx(
            () => controller.dateError.value
                ? Text(
                    controller.dateValidationMessage.value,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png','JPEG'],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                          picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      setState(() {
                        controller.dynamicList[index].imagePassportSizePhoto =
                            picked.files.first.name;
                        controller.dynamicList[index].visapathPassportSizePhoto= picked;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imagePassportSizePhoto.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Get a passport sized picture with a white background and take a picture of it.Make sure the picture is in focus *Do not take a selfie.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to include the border around it.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passportPhoto)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          controller.dynamicList[index].CountryName=="India"?SizedBox():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png',"JPEG"],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                              picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      controller.dynamicList[index].visapathColoredPassport = picked;

                      setState(() {
                        controller.dynamicList[index].imageColoredPassport =
                            picked.files.first.name;
                        //  strNoFileChose = picked.files.first.name;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imageColoredPassport.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Take a clear picture of the passport(First Page), make sure it is in focus",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to make sure to include the bottom two lines of the page.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("*Passport Edges must be clear and visible*",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passport)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          controller.dynamicList[index].CountryName=="India"?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png','JPEG'],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                          picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      setState(() {
                        controller.dynamicList[index].imageIndiaFirst =
                            picked.files.first.name;
                        controller.dynamicList[index].visapathIndiaFirst = picked;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imageIndiaFirst.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Get a passport sized picture with a white background and take a picture of it.Make sure the picture is in focus *Do not take a selfie.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to include the border around it.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passportPhoto)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ):SizedBox(),
          controller.dynamicList[index].CountryName=="India"?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png','JPEG'],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                          picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      setState(() {
                        controller.dynamicList[index].imageIndiaLast =
                            picked.files.first.name;
                        controller.dynamicList[index].visapathIndiaLast = picked;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imageIndiaLast.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Get a passport sized picture with a white background and take a picture of it.Make sure the picture is in focus *Do not take a selfie.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to include the border around it.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passportPhoto)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ):SizedBox(),
          controller.dynamicList[index].CountryName=="Pakistan"?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png','JPEG'],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                          picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      setState(() {
                        controller.dynamicList[index].imagePakistanFront =
                            picked.files.first.name;
                        controller.dynamicList[index].visapathPakistanFront = picked;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imagePakistanFront.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Get a passport sized picture with a white background and take a picture of it.Make sure the picture is in focus *Do not take a selfie.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to include the border around it.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passportPhoto)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ):SizedBox(),
          controller.dynamicList[index].CountryName=="Pakistan"?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color:colorBlue),
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png','JPEG'],);
                    if (picked == null) {
                      Center(child: CircularProgressIndicator());
                    } else {
                      print(picked.files.first.name != null &&
                          picked.files.first.name != ""
                          ? picked.files.first.name
                          : "");
                      setState(() {
                        controller.dynamicList[index].imagePakistanBack =
                            picked.files.first.name;
                        controller.dynamicList[index].visapathPakistanBack = picked;
                      });
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(
                    primary: colorBlue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(controller.dynamicList[index].imagePakistanBack.toString(),
                        style: TextStyle(fontSize: 14.sp)),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("PASSPORT VALIDITY NOT LESS THAN 6 MONTHS",style: TextStyle(color: Colors.red,fontSize: 20.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 20.h,),
                                Text("Step 1: Get a passport sized picture with a white background and take a picture of it.Make sure the picture is in focus *Do not take a selfie.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 2: Adjust and crop the picture to include the border around it.",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Step 3: Final image should look like the image sample below",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Text("Size width 620px by height 800px",style: TextStyle(color: Colors.black,fontSize: 16.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                SizedBox(height: 5.h,),
                                Align(alignment: Alignment.center,
                                    child: Image.asset(passportPhoto)),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                    height: 40.h,
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: colorYellow),
                                    child: Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: colorWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        helpImage,
                        height: 18.h,
                        width: 18.h,
                      ),
                    )
                  ],
                ),
              )
            ],
          ):SizedBox(),
        ],
      ),
    );
  }
}

class SelectIndex {
  String? value;
  bool? isSelected;

  SelectIndex({this.value, this.isSelected});
}

class VisaValue {
  String? title;
  String? firstName;
  String? lastName;
  String? CountryId;
  String? CountryName;
  String? travelDate;
  String? imageColoredPassport = "Colored Passport";
  String? imagePassportSizePhoto = "Passport size Photo";
  String? imageIndiaFirst = "Colored Passport(First Page)";
  String? imageIndiaLast = "Colored Passport(Last Page)";
  String? imagePakistanFront = "Pakistan National ID(front)";
  String? imagePakistanBack = "Passport National ID(back)";
  FilePickerResult? visapathColoredPassport;
  FilePickerResult? visapathPassportSizePhoto;
  FilePickerResult? visapathIndiaFirst;
  FilePickerResult? visapathIndiaLast;
  FilePickerResult? visapathPakistanFront;
  FilePickerResult? visapathPakistanBack;

  VisaValue(
      {this.title,
      this.firstName,
      this.lastName,
      this.CountryId,
      this.CountryName,
      this.travelDate,
      this.imageColoredPassport,
      this.imagePassportSizePhoto,
      this.imageIndiaFirst,
      this.imageIndiaLast,
      this.imagePakistanFront,
      this.imagePakistanBack,
      this.visapathColoredPassport,
      this.visapathPassportSizePhoto,
      this.visapathIndiaFirst,
      this.visapathIndiaLast,
      this.visapathPakistanFront,
      this.visapathPakistanBack});
}
