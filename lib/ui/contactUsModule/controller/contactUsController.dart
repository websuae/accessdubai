import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/contactUsModule/model/contactUsModel.dart';
import '../../../webservice.dart';

class ContactUsController extends GetxController {
  var loader=false.obs;

  var nameController = TextEditingController();
  var nameError = true.obs;
  var nameValidationMessage = "".obs;

  var messageController = TextEditingController();
  var messageError = true.obs;
  var messageValidationMessage = "".obs;

  // email Variables for controller validations
  var emailController = TextEditingController();
  var emailError = true.obs;
  var emailValidationMessage = "".obs;

  //Mobile variables for controller validations
  var mobileController = TextEditingController();
  var mobileError = true.obs;
  var mobileValidationMessage = "".obs;


  var isValidValidation = false.obs;


  checkName(String name) {
    if (name == "") {
      nameError.value = true;
      nameValidationMessage.value = "Please enter your name";
    } else {
      nameError.value = false;
    }
    checkValidation();
  }

  checkEmail(String email) {
    if (email == "") {
      emailError.value = true;
      emailValidationMessage.value = "Please enter email";
    } else if (!isEmail(email)) {
      emailError.value = true;
      emailValidationMessage.value = "Please enter valid email";
    } else {
      emailError.value = false;
    }
    checkValidation();
  }

  checkMessage(String message) {
    if (message == "") {
      messageError.value = true;
      messageValidationMessage.value = "Please enter yout message.";
    } else {
      messageError.value = false;
    }
    checkValidation();
  }

  checkMobile(String mobile) {
    if (mobile == "") {
      mobileError.value = true;
      mobileValidationMessage.value = "Please enter mobile number";
    }
    else{
      mobileError.value = false;
    }
    checkValidation();
  }


  void checkValidation() {
    if ( (!nameError.value) && (!emailError.value)  && (!mobileError.value) && (!messageError.value) ){
      isValidValidation.value = true;
      print("iff");
    } else {
      isValidValidation.value = false;
      print("else");
    }
  }

  contactUsApi() {
    loader.value = true;
    Map<String, dynamic> map = Map<String, dynamic>();
    map["user_id"] ="0";
    map["cntname"] =nameController.text;
    map["cntemail"] =emailController.text;
    map["cntphone"] =mobileController.text;
    map["cntmessage"] =messageController.text;

    Webservice().loadPost(getContactUs, map).then(
          (model) => {
        print("name is::" + model.message.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<ContactUsResponse> get getContactUs {
    return Resource(
        url: ApiEndpoint.contactUs,
        parse: (response) {
          var result;
          //     Get.back();
          //      final result = json.decode(response.body);
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
           Get.snackbar("weldone", "We will contact you in short time.");
            return contactUsResponseFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("oooopss", message);
            return contactUsResponseFromJson(response.body);
          }
        });
  }
}