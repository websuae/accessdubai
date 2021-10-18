import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/HomeModule/view/homeScreen.dart';
import 'package:visa_app/ui/signInModule/model/LoginResponceModel.dart';
import 'package:visa_app/webservice.dart';

class SignInController extends GetxController {
  // email Variables for controller validations

  var loader=false.obs;
  var emailController = TextEditingController();
  var emailError = true.obs;
  var emailValidationMessage = "".obs;

  // password Variables for controller validations
  var passwordController = TextEditingController();
  var passError = true.obs;
  var passwordValidationMessage = "".obs;

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

  checkPassword(String password) {
    if (password == "") {
      passError.value = true;
      passwordValidationMessage.value = "Please enter Password";
    }
    // else if (!validatePassword(password)) {
    //   passError.value = true;
    //   passwordValidationMessage.value = "Please enter valid password";
    // }
    else {
      passError.value = false;
    }
    checkValidation();
  }

  void checkValidation() {
    if ((!emailError.value) && (!passError.value)) {
      isValidValidation.value = true;
    } else {
      isValidValidation.value = false;
    }
  }

  doLoginApi() async {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["action"] = "dologin";
    map["uemail"] = emailController.text;
    map["upass"] = passwordController.text;

    Webservice().loadPost(getSignIn, map).then(
          (model) => {
            print("name is::" + model.userName.toString()),
            if (model.status == "true") {
              Get.offAll(HomePage())
            } else {}
            // {storage.write(isLogin, false)}
          },
        );
  }

  Resource<LoginResponceModel> get getSignIn {
    return Resource(
        url: ApiEndpoint.login,
        parse: (response) {
          var result;
          //     Get.back();
          //      final result = json.decode(response.body);
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
          } else {
            print("empty responce");
          }
          print("" + ".......getSupplierLogin......." + result.toString());
          String success = result["status"];
          if (success == "true") {
            loader.value=false;
            return loginResponceModelFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("dfasdf", message);
            return loginResponceModelFromJson(response.body);
          }
          return result;
        });
  }
}
