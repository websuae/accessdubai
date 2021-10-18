import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/forgetPasswordModule/model/ForgotPasswordResponseModel.dart';
import '../../../webservice.dart';

class ForgotPasswordController extends GetxController {
// email Variables for controller validations
  var emailController = TextEditingController();
  var emailError = false.obs;
  var emailValidationMessage = "".obs;

  // button check variable
  var isValidValidation = false.obs;

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

  void checkValidation() {
    if ((!emailError.value)) {
      isValidValidation.value = true;
    } else {
      isValidValidation.value = false;
    }
  }

  forgotPasswordApi() async {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["action"] = "resetpassword";
    map["uemail"] = emailController.text;

    Webservice().loadPost(getForgotPassword, map).then(
          (model) => {
            print("name is::" + model.message.toString()),
            if (model.status == "true") {
              Get.back()
            } else {
              
            }
          },
        );
  }

  Resource<ForgotPasswordResponseModel> get getForgotPassword {
    return Resource(
        url: ApiEndpoint.forgotPassword,
        parse: (response) {
          var result;
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
          } else {
            print("empty responce");
          }
          print("" + ".......getSupplierLogin......." + result.toString());
          String success = result["status"];
          if (success == "true") {
            print(response.statusCode);
            return forgotPasswordResponseModelFromJson(response.body);
          } else {
            String message = result["message"];
            Get.snackbar("errorMessage", message);
            return forgotPasswordResponseModelFromJson(response.body);
          }
          return result;
        });
  }
}
