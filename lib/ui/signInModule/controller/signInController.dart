import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
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
  final storage = GetStorage();

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

              addBoolToSF(true,model),

              Get.offAll(HomePage())
            } else {
             addBoolToSF(false,model),

            }
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
            Get.snackbar("ooopsss", message);
            return loginResponceModelFromJson(response.body);
          }
        });
  }

  addBoolToSF(bool value,LoginResponceModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
    if(value){
      prefs.setString(userName, model.userName.toString());
      prefs.setString(userEmail, model.userEmail.toString());
      prefs.setString(userId, model.userId.toString());
      print("name of user"+prefs.getString(userName).toString());
    }
  }
}
