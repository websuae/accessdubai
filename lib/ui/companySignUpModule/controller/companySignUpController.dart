import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CompanySignUpController extends GetxController {
  CompanySignUpController controller = Get.put(CompanySignUpController());

  // Company module..............

  var companyTitleController = TextEditingController();
  var companyTitleError = false.obs;
  var companyTitleValidationMessage = "".obs;

  var companyEmailController = TextEditingController();
  var companyEmailError = false.obs;
  var companyEmailValidationMessage = "".obs;

  var companyPasswordController = TextEditingController();
  var companyPasswordError = false.obs;
  var companyPasswordValidationMessage = "".obs;

  var companyMobileController = TextEditingController();
  var companyMobileError = false.obs;
  var companyMobileValidationMessage = "".obs;

  var companyContactPersonController = TextEditingController();
  var companyContactPersonError = false.obs;
  var companyContactPersonValidationMesaage = "".obs;

  var companyDesignationController = TextEditingController();
  var companyDesignationError = false.obs;
  var companyDesignationValidationMessage = "".obs;

  var companyLicenseNumberController = TextEditingController();
  var companyLicenseNumberError = false.obs;
  var companyLicenseNumberValidationMessage = "".obs;

  var companyYearOfRegistrationController = TextEditingController();
  var companyYearOfRegistrationError = false.obs;
  var companyYearOfRegistrationValidationMessage = "".obs;

  var companyAddressController = TextEditingController();
  var companyAddressError = false.obs;
  var companyAddressValidationMessage = "".obs;

  var companyMessageController = TextEditingController();
  var companyMessageError = false.obs;
  var companyMessageValidationMessage = "".obs;

}