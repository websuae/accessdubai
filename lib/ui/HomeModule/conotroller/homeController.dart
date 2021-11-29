import 'dart:convert';
import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/HomeModule/model/countryModel.dart';
import '../../../webservice.dart';

class HomeController extends GetxController {
  var countryDropDownName = "".obs;
  var countryList = [].obs;
  var countryList1 = [].obs;
  late CountryResponse country;
  var loader = false.obs;
  String serchValue="";

  getCountryListApi() {
    loader.value=true;
    Map<String, dynamic> map = Map<String, dynamic>();
    map["search"] = serchValue;
      print("Search:"+serchValue);
    Webservice().loadPost(getCountryList, map).then(
          (model) =>
      {
        print("name is::" + model.message.toString()),
        if (model.status == true) {
        } else
          {}
      },
    );
  }


  Resource<CountryResponse> get getCountryList {
    return Resource(
        url: ApiEndpoint.countryList+"?search="+serchValue,
        parse: (response) {
          var result;
          if (response.body.isNotEmpty) {
            result = json.decode(response.body);
          }
          else {
            print("empty responce");
          }
          print("" + ".......getSupplier......" + result.toString());

          bool success = result["status"];
          if (success == true) {
            loader.value = false;
            countryList.clear();
            country = CountryResponse.fromJson(json.decode(response.body));
            countryList.addAll(country.data!);
            print("length of list::" + countryList.length.toString());
            return countryResponseFromJson(response.body);
          } else {
            loader.value = false;
            String message = result["message"];
            Get.snackbar("dfasdf", message);
            return countryResponseFromJson(response.body);
          }
        });
  }

}
