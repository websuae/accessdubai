import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_app/constants/constants.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/HomeModule/view/homeScreen.dart';
import 'package:visa_app/ui/signUpModule/model/SignUpResponseModel.dart';

import '../../../webservice.dart';

class SignUpController extends GetxController {
  //User module..................

  BuildContext? context;
  SignUpController({this.context});

  var loader=false.obs;
  var countryDropDownName = "".obs;
  var nationError = true.obs;
  var nationValidationMessage = "".obs;

  var nameController = TextEditingController();
  var nameError = true.obs;
  var nameValidationMessage = "".obs;

  // email Variables for controller validations
  var emailController = TextEditingController();
  var emailError = true.obs;
  var emailValidationMessage = "".obs;

  // password Variables for controller validations
  var passwordController = TextEditingController();
  var passError = true.obs;
  var passwordValidationMessage = "".obs;

  //Mobile variables for controller validations
  var mobileController = TextEditingController();
  var mobileError = true.obs;
  var mobileValidationMessage = "".obs;


  // button check variable
  var isValidValidation = false.obs;
  var countryCode="+91";

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

  checkPassword(String password) {
    if (password == "") {
      passError.value = true;
      passwordValidationMessage.value = "Please enter Password";
    } else {
      passError.value = false;
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

  checkNationality(String nation) {
    if(nation == "Nationality") {
      print("nation:"+nation);
      nationError.value = true;
      nationValidationMessage.value = "Please select your nation";
    }
    else{
      print("nation:"+nation);
      nationError.value = false;
    }
    checkValidation();
  }

  void checkValidation() {
    print("nationError:"+nationError.toString());
    if ( (!nameError.value) && (!emailError.value) && (!passError.value) && (!mobileError.value) && (!nationError.value)){
      isValidValidation.value = true;
    } else {
      isValidValidation.value = false;
    }
  }

  doSignUpApi() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["action"] = "newregister";
    map["uname"] = nameController.text;
    map["uemail"] = emailController.text;
    map["upass"] = passwordController.text;
    map["umobile"] = countryCode+" "+mobileController.text;
    map["unationality"] = countryDropDownName.value;

    Webservice().loadPost(getSignUp, map).then(
          (model) => {
            print("name is::" + model.message.toString()),
            if (model.status == "true") {

              addBoolToSF(true,model),
              Get.offAll(HomePage())

            } else {
              addBoolToSF(false,model),

            }

          },
        );
  }

  Resource<SignUpResponceModel> get getSignUp {
    return Resource(
        url: ApiEndpoint.signUp,
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
          String success = result["status"];
          if (success=="true") {
            loader.value=false;
            return signUpResponceModelFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("dfasdf", message);
            return signUpResponceModelFromJson(response.body);
          }
        });
  }
  addBoolToSF(bool value,SignUpResponceModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
    if(value){
      prefs.setString(userName, nameController.text.toString());
      prefs.setString(userEmail, model.registrationEmail.toString());
      prefs.setString(userId, model.registrationId.toString());
      print("name of user"+prefs.getString(userName).toString());
    }
  }
}
