import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/HomeModule/model/countryModel.dart';
import 'package:visa_app/ui/applyVisaModule/model/CommonResponse.dart';
import 'package:visa_app/ui/applyVisaModule/view/applyVisaScreen.dart';
import 'package:visa_app/ui/trackApplicationModule/view/trackApplicationScreen.dart';
import 'package:visa_app/webservice.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApplyVisaController extends GetxController {
  var isSelected=false.obs;
  var countryDropDownName = "".obs;
  List<VisaValue> dynamicList=[];

  var firstNameController = TextEditingController();
  var firstNameError = true.obs;
  var firstNameValidationMessage = "".obs;

  var lastNameController = TextEditingController();
  var lastNameError = true.obs;
  var lastNameValidationMessage = "".obs;

  var dateController = TextEditingController();
  var dateError = true.obs;
  var dateValidationMessage = "".obs;

  var childWidgetLength=0.obs;

  var isChecked = false.obs;
  var count=0;
  String applicationNumber="";
  String userIds ="";
  var prefix ;

  // For country api
  late CountryResponse country;
  var loader=true.obs;
  var countryList=[].obs;
  bool isComplete=false;

  checkName(String name) {
    if (name == "") {
      firstNameError.value = true;
      firstNameValidationMessage.value = "Please enter your name";
    } else {
      firstNameError.value = false;
    }
  }

  cleanController() {
    childWidgetLength.value=0;
  }


  doApplyVisa(String appDay,int appPerson,int userId,
      String title,String firstName,String lastName,String countryName,int countryId,
      String appDate,String passortSizePhoto,String colouredPassort,String colouredPassort_First_Page,
      String colouredPassort_Last_Page,String pakistanNational_ID_Front,String pakistan_National_ID_Back ) async{
    var request = new http.MultipartRequest("POST", Uri.parse(ApiEndpoint.applyForVisa));
    request.fields['applicationDays'] = appDay.toString();
    request.fields['applicationPerson'] = appPerson.toString();
    request.fields["userId"] = userId.toString();
    request.fields["applicationNumber"] = applicationNumber;
    request.fields["title"] = title;
    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["countryName"] = countryName;
    request.fields["countryId"] = countryId.toString();
    request.fields["applicationDate"] = appDate;
    request.fields["colouredPassort"] = colouredPassort;
    request.fields["passortSizePhoto"] = passortSizePhoto;
    request.fields["colouredPassort_First_Page"] = colouredPassort_First_Page;
    request.fields["colouredPassort_Last_Page"] = colouredPassort_Last_Page;
    request.fields["pakistanNational_ID_Front"] = pakistanNational_ID_Front;
    request.fields["pakistan_National_ID_Back"] = pakistan_National_ID_Back;

    if(colouredPassort != "") {
      request.files.add(
          await http.MultipartFile.fromPath('colouredPassort', colouredPassort,
              contentType: MediaType('image', '')));
    }

    if(passortSizePhoto != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'passortSizePhoto', passortSizePhoto,
          contentType: new MediaType('image', '')));
    }

    if(colouredPassort_First_Page != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'colouredPassort_First_Page', colouredPassort_First_Page,
          contentType: MediaType('image', '')));
    }
    if(colouredPassort_Last_Page != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'colouredPassort_Last_Page', colouredPassort_Last_Page,
          contentType: new MediaType('image', '')));
    }

    if(pakistanNational_ID_Front != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'pakistanNational_ID_Front', pakistanNational_ID_Front,
          contentType: new MediaType('image', '')));
    }

    if(pakistan_National_ID_Back != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'pakistan_National_ID_Back', pakistan_National_ID_Back,
          contentType: new MediaType('image', '')));
    }

    // var response = await request.send();
    // print(response.stream);
    // print(response.statusCode);


    request.send().then((response)  async {
      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        CommonResponce commonModel = commonResponceFromJson(res.body);
        print("Response of image api:" + commonModel.applicationId.toString());
        print("Uploaded!");
        applicationNumber=commonModel.applicationId.toString();
              print("application number:"+applicationNumber);
              if(dynamicList.length>1){
                for(int i = 0; i < dynamicList.length - 1; i++)
                  {
                    {
                      doApplyVisa(
                        prefix,
                        dynamicList.length,
                        int.parse(userIds),
                      dynamicList[i+1].title.toString(),
                        dynamicList[i+1].firstName
                            .toString(),
                       dynamicList[i+1].lastName.toString(),
                       dynamicList[i+1].CountryName
                            .toString(),
                        int.parse(dynamicList[i+1].CountryId
                            .toString()),
                        dateController.text.toString(),

                        dynamicList[i+1].visapathPassportSizePhoto!.paths
                            .first
                            .toString(),

                       dynamicList[i+1].CountryName=="India"?""
                            :dynamicList[i+1].visapathColoredPassport!.paths
                            .first
                            .toString(),


                       dynamicList[i+1].CountryName=="India"?
                        dynamicList[i+1].visapathIndiaFirst!.paths.first
                            .toString():"",


                        dynamicList[i+1].CountryName=="India"?
                        dynamicList[i+1].visapathIndiaLast!.paths.first
                            .toString():"",


                        dynamicList[i+1].CountryName=="Pakistan"?
                        dynamicList[i+1].visapathPakistanFront!.paths
                            .first
                            .toString():"",


                        dynamicList[i+1].CountryName=="Pakistan"?
                        dynamicList[i+1].visapathPakistanBack!.paths
                            .first
                            .toString():"",);
                    }

                  };
                dynamicList.clear();
                Timer(Duration(milliseconds: 10000), () {
                  applicationNumber="";
                  Get.to(TrackApplicationPage(applicationNumber: commonModel.applicatioNumber,));
                });

              }
              else{
                applicationNumber="";
                Get.to(TrackApplicationPage(applicationNumber: commonModel.applicatioNumber,));
              }
      }
      else{
        print("error!");
      }
    });
    print("appDay:"+appDay.toString());
    print("appPerson:"+appPerson.toString());
    print("userId:"+userId.toString());
    print("applicationNumber:"+applicationNumber.toString());
    print("title:"+title.toString());
    print("firstName:"+firstName.toString());
    print("lastName:"+lastName.toString());
    print("countryName:"+countryName.toString());
    print("countryId:"+countryId.toString());
    print("appDate:"+appDate.toString());
    print("colouredPassort:"+colouredPassort.toString());
    print("passortSizePhoto:"+passortSizePhoto.toString());
    print("colouredPassort_First_Page:"+colouredPassort_First_Page.toString());
    print("colouredPassort_Last_Page:"+colouredPassort_Last_Page.toString());
    print("pakistanNational_ID_Front:"+pakistanNational_ID_Front.toString());
    print("pakistan_National_ID_Back:"+pakistan_National_ID_Back.toString());

    // Map<String, dynamic> map = Map<String, dynamic>();
    // map["applicationDays"] = appDay.toString();
    // map["applicationPerson"] = appPerson.toString();
    // map["userId"] = userId.toString();
    // map["applicationNumber"] = applicationNumber;
    // map["title"] = title;
    // map["firstName"] = firstName;
    // map["lastName"] = lastName;
    // map["countryName"] = countryName;
    // map["countryId"] = countryId.toString();
    // map["applicationDate"] = appDate;
    // map["colouredPassort"] = colouredPassort;
    // map["passortSizePhoto"] = passortSizePhoto;
    // map["colouredPassort_First_Page"] = colouredPassort_First_Page;
    // map["colouredPassort_Last_Page"] = colouredPassort_Last_Page;
    // map["pakistanNational_ID_Front"] = pakistanNational_ID_Front;
    // map["pakistan_National_ID_Back"] = pakistan_National_ID_Back;
    //
    // Webservice().loadPost(applyVisa, map).then(
    //       (model) => {
    //     print("name is::" + model.message.toString()),
    //         applicationNumber=model.applicationId.toString(),
    //         print("application number:"+applicationNumber),
    //         if(dynamicList.length>1){
    //           for(int i = 0; i < dynamicList.length - 1; i++)
    //             {
    //               doApplyVisa(
    //                   prefix,
    //                   dynamicList.length,
    //                   int.parse(userIds),
    //                   dynamicList[i + 1].title.toString(),
    //                   dynamicList[i + 1].firstName.toString(),
    //                   dynamicList[i + 1].lastName.toString(),
    //                   dynamicList[i + 1].CountryName.toString(),
    //                   int.parse(dynamicList[i + 1].CountryId.toString()),
    //                   dateController.text.toString(),
    //                   "",
    //                   "",
    //                   "",
    //                   "",
    //                   "",
    //                   ""),
    //
    //             },
    //           dynamicList.clear(),
    //          Get.to(TrackApplicationPage(applicationNumber: model.applicatioNumber,))
    //         }
    //         else{
    //           Get.to(TrackApplicationPage(applicationNumber: model.applicatioNumber,))
    //         }
    //     // if (model.status == "true") {
    //
    //       // Navigator.pushReplacement(
    //       //   context,
    //       //   MaterialPageRoute(
    //       //       builder: (context) => HomePage()),
    //       // )
    //     // } else {}
    //   },
    // );
    // loadPostWithImage(applyVisa).then(
    //       (model) => {
    //     print("name is::" + model.message.toString()),
    //     applicationNumber=model.applicationId.toString(),
    //     print("application number:"+applicationNumber),
    //     if(dynamicList.length>1){
    //       for(int i = 0; i < dynamicList.length - 1; i++)
    //         {
    //           doApplyVisa(
    //               prefix,
    //               dynamicList.length,
    //               int.parse(userIds),
    //               dynamicList[i + 1].title.toString(),
    //               dynamicList[i + 1].firstName.toString(),
    //               dynamicList[i + 1].lastName.toString(),
    //               dynamicList[i + 1].CountryName.toString(),
    //               int.parse(dynamicList[i + 1].CountryId.toString()),
    //               dateController.text.toString(),
    //               "",
    //               "",
    //               "",
    //               "",
    //               "",
    //               ""),
    //
    //         },
    //       dynamicList.clear(),
    //       Get.to(TrackApplicationPage(applicationNumber: model.applicatioNumber,))
    //     }
    //     else{
    //       Get.to(TrackApplicationPage(applicationNumber: model.applicatioNumber,))
    //     }
    //     // if (model.status == "true") {
    //
    //     // Navigator.pushReplacement(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //       builder: (context) => HomePage()),
    //     // )
    //     // } else {}
    //   },
    // );
  }

  // doApplyVisa1(List<VisaValue> dynamicList) {
  //   Map<String, dynamic> map = Map<String, dynamic>();
  //   map["applicationDays"] = "";
  //   map["applicationPerson"] = "";
  //   map["userId"] = "";
  //   map["applicationNumber"] = "";
  //   map["title"] = "";
  //   map["firstName"] = "";
  //   map["lastName"] = "";
  //   map["countryName"] = "";
  //   map["countryId"] = "";
  //   map["applicationDate"] = "";
  //   map["colouredPassort"] = "";
  //   map["passortSizePhoto"] = "";
  //   map["colouredPassort_First_Page"] = "";
  //   map["colouredPassort_Last_Page"] = "";
  //   map["pakistanNational_ID_Front"] = "";
  //   map["pakistan_National_ID_Back"] = "";
  //
  //   Webservice().loadPost(applyVisa, map).then(
  //         (model) => {
  //       print("name is::" + model.message.toString()),
  //       // if (model.status == "true") {
  //       //  // Get.offAll(HomePage())
  //       //   // Navigator.pushReplacement(
  //       //   //   context,
  //       //   //   MaterialPageRoute(
  //       //   //       builder: (context) => HomePage()),
  //       //   // )
  //       // } else {}
  //     },
  //   );
  // }

  Resource<CommonResponce> get applyVisa {
    return Resource(
        url: ApiEndpoint.applyForVisa,
        parse: (response) {
          var result;
          //     Get.back();
          //      final result = json.decode(response.body);
          if(response.body.isNotEmpty) {
            result= json.decode(response.body);

          }
          else
          {
            print("empty responce");
          }
          print("" + ".......getSupplierLogin......." + result.toString());
          // return commonResponceFromJson(response.body);
          bool success = result["status"];

          if (success) {
            return commonResponceFromJson(response.body);
          } else {

            String message = result["message"];
            Get.snackbar("dfasdf", message);
            return commonResponceFromJson(response.body);
          }
        });
  }

  // Future<T> loadPostWithImage<T>(Resource<T> resource) async {
  //   //final response = await http.post(Uri.parse(resource.url), body: body);
  //   final response = await http.MultipartRequest("POST", Uri.parse(resource.url));
  //   // final response = await http.http.MultipartRequest("POST", postUri);
  //   print("response........................." + response.toString());
  //   // print("response........................." + response.statusCode.toString());
  //   // throw Exception('Failed to load data!');
  //
  //   if (response.statusCode == 200) {
  //     return resource.parse(response);
  //   } else {
  //     throw Exception('Failed to load data!');
  //   }
  // }

  getCountryListApi() {
    Map<String, dynamic> map = Map<String, dynamic>();

    Webservice().loadPost(getCountryList, map).then(
          (model) => {
        print("name is::" + model.message.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<CountryResponse> get getCountryList {
    return Resource(
        url: ApiEndpoint.countryList,
        parse: (response) {
          var result;
          if(response.body.isNotEmpty) {
            result= json.decode(response.body);
          }
          else {
            print("empty responce");
          }
          print("" + ".......getSupplier......" + result.toString());

          bool success = result["status"];
          if (success==true) {
            loader.value=false;
            country=CountryResponse.fromJson(json.decode(response.body));
            countryList.addAll(country.data!);
            print("length of list::"+countryList.length.toString());
            return countryResponseFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("dfasdf", message);
            return countryResponseFromJson(response.body);
          }
        });
  }
}