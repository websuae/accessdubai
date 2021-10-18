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
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/constants/stringConstants.dart';
import 'package:visa_app/model/Nationality.dart';
import 'package:visa_app/ui/applyVisaModule/controller/applyVisaController.dart';
import 'package:visa_app/widget/commonAppBar.dart';
import 'package:visa_app/widget/commonSignupTextField.dart';

class ApplyVisaPage extends StatefulWidget {
  const ApplyVisaPage({Key? key}) : super(key: key);

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
  var strNoFileChose = "Colored Passport";

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode nationalityFocus = FocusNode();

  @override
  void initState() {
    super.initState();
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
                logo,
                height: 35.h,
                width: 35.h,
              ),
            )
          ],
        ),
        body: Container(
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
                          ));
                        },
                      );
                    }).toList(),
                  ),
                  Center(
                    child: Text(
                      "UAE VISA apply \nonline",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: colorWhite),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "30 Days Visa",
                style: TextStyle(
                    color: colorBlue,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Number of Application",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Container(
                    height: 80.h,
                    width: 240.w,
                    child: GridView.count(
                      // crossAxisCount is the number of items
                      crossAxisCount: 5,
                      // This creates two columns with two items in each column
                      children:
                          List.generate(applyVisaNumberList.length, (index) {
                        return visaPageCounter(
                            applyVisaNumberList,
                            applyVisaNumberList[index].value.toString(),
                            index,
                            true);
                      }),
                    )),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.childWidgetLength.value,
                    itemBuilder: (BuildContext context, int index) {
                      return visaFormContainer();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget visaPageCounter(List<SelectIndex> applyVisaNumber, String text, int index, bool isFisrst) {
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
                        print("i:" + i.toString());
                        if (i == index) {
                          controller.childWidgetLength.value =
                              int.parse(applyVisaNumber[i].value!);
                          applyVisaNumber[i].isSelected = true;
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

  Future<void> _selectDate(BuildContext context) async {
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
        ;
      });
  }

  Widget visaFormContainer() {
    return Padding(
      padding: EdgeInsets.all(10.h),
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
              hint: _countryDropDownName == null
                  ? Text('Title')
                  : Text(
                      _countryDropDownName!,
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
                  _countryDropDownName = value;
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
              focusNode: firstNameFocus,
              onChanged: (String password) {
                // validation binding from controller class
                controller.checkName(password);
              },
              // binding Getx Controller to textField controller
              controller: controller.firstNameController,
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
              focusNode: lastNameFocus,
              onChanged: (String password) {
                // validation binding from controller class
                controller.checkName(password);
              },
              // binding Getx Controller to textField controller
              controller: controller.lastNameController,
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
                    child: DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      focusNode: nationalityFocus,
                      iconEnabledColor: colorBlack,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      alignment: Alignment.centerRight,
                      hint: Obx(
                        () => controller.countryDropDownName.value == ""
                            ? Text('Nationality',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                controller.countryDropDownName.value,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
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
                        controller.countryDropDownName.value = value.toString();
                        controller.countryDropDownName.value;
                      },
                    ),
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
                _selectDate(context);
              },
              // binding Getx Controller to textField controller
              controller: controller.dateController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.none),
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
                  child: Icon(Icons.cloud_upload),
                  style: ElevatedButton.styleFrom(primary: colorBlue,shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Row(
                  children: [
                    Text(strNoFileChose, style: TextStyle(fontSize: 14.sp)),
                    SizedBox(width: 5.w,),
                    Image.asset(helpImage, height: 18.h,width: 18.h,)
                  ],
                ),
              )
            ],
          ),
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
