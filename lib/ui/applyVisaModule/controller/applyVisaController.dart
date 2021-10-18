import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ApplyVisaController extends GetxController {
  var isSelected=false.obs;
  var countryDropDownName = "".obs;


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

  checkName(String name) {
    if (name == "") {
      firstNameError.value = true;
      firstNameValidationMessage.value = "Please enter your name";
    } else {
      firstNameError.value = false;
    }
  }

}