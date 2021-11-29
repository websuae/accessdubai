class ApiEndpoint {
  static final String baseUrl = "https://mydubai.app/client/travel/api";

  //end points
  static String login = baseUrl + "/Users/login";
  static String signUp = baseUrl + "/Users/register";
  static String forgotPassword = baseUrl + "/Users/forgetpassword";
  static String visaType = baseUrl + "/Users/get_visatype";
  static String countryList = baseUrl + "/Users/get_countries_api";
  static String selectVisatype = baseUrl + "/Users/get_countries_price";
  static String applyForVisa = baseUrl + "/Users/applyForVisa";
  static String tracking = baseUrl + "/Users/checkApplicationStatus";
  static String faq = baseUrl + "/Users/faq";
  static String contactUs = baseUrl + "/Users/contact_us";
  static String whyUs = baseUrl + "/Users/why_us";
  static String getCountryVisaPrice = baseUrl + "/Users/get_cuntries_visa_price";
  static String getPrivacyPolicy = baseUrl + "/Users/privacy_policy";
}