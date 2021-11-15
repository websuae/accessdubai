import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/signUpModule/model/SignUpResponseModel.dart';
import 'package:visa_app/ui/trackApplicationModule/model/TrackApplicationModel.dart';

import '../../../webservice.dart';

class TrackApplicationController extends GetxController {
  var applicationNumberController = TextEditingController();
  var userApplication= [].obs ;
  TrackApplicationModel trackApplicationModel=TrackApplicationModel();
  var loader=false.obs;

  doTrackingApi() {
    loader.value=true;
    Map<String, dynamic> map = Map<String, dynamic>();
    map["applicationNumber"] =applicationNumberController.text ;

    Webservice().loadPost(getTrack, map).then(
          (model) => {
        print("name is::" + model.message.toString()),
        /* if (model.status == "true") {
          Get.offAll(HomePage())
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          )
        } else {}*/
      },
    );
  }

  Resource<TrackApplicationModel> get getTrack {
    return Resource(
        url: ApiEndpoint.tracking,
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
          userApplication.clear();
          trackApplicationModel=TrackApplicationModel.fromJson(json.decode(response.body));
          userApplication.addAll(trackApplicationModel.applicationUser!) ;
          loader.value=false;
          // String success = result["status"];
          // if (success=="true") {
          //   //loader.value=false;
          //   return trackApplicationModelFromJson(response.body);
          // } else {
          //   //loader.value=false;
          //   String message = result["message"];
          //   Get.snackbar("dfasdf", message);
          //   return trackApplicationModelFromJson(response.body);
          //}
          return trackApplicationModelFromJson(response.body);
        });
  }
}