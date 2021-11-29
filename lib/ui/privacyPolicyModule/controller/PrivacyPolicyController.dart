import 'dart:convert';
import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/privacyPolicyModule/model/PrivacyPolicyModel.dart';
import 'package:visa_app/ui/typesOfVisaModule/model/typesOfVisaModel.dart';
import '../../../webservice.dart';

class PrivacyPolicyController extends GetxController {
  var loader=false.obs;
  //List<Datum> visaTypeList= [];
  var privacyPolicyList= [].obs ;
  late PrivacyPolicyModel privacyPolicyModel;

  privacyPolicyApi() {
    loader.value = true;
    Map<String, dynamic> map = Map<String, dynamic>();

    Webservice().loadPost(getPrivacyPolicy, map).then(
          (model) => {
        //print("name is::" + model.data!.privacyName.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<PrivacyPolicyModel> get getPrivacyPolicy {
    return Resource(
        url: ApiEndpoint.getPrivacyPolicy,
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
            privacyPolicyModel=PrivacyPolicyModel.fromJson(json.decode(response.body));
            privacyPolicyList.addAll(privacyPolicyModel.data!);

            return privacyPolicyModelFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("oooopss", message);
            return privacyPolicyModelFromJson(response.body);
          }
        });
  }
}