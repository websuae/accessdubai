import 'dart:convert';

import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/applyVisaFirstStepModule/model/ApplyVisaFirstStepModel.dart';
import 'package:visa_app/ui/applyVisaModule/view/applyVisaScreen.dart';

import '../../../webservice.dart';

class ApplyVisaFirstStepController extends GetxController {

  var loader=false.obs;
  var visaFirstStepList= [].obs ;
  late ApplyVisaFirstStepModel applyVisaFirstStepModel;
  late String selectedCountryId;

  applyVisaFirstStepApi() {
     loader.value = true;
    Map<String, dynamic> map = Map<String, dynamic>();
   // map["country_check"] = selectedCountryId;



    Webservice().loadPost(selectVisaPlanType, map).then(
          (model) => {
        print("name is::" + model.message.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<ApplyVisaFirstStepModel> get selectVisaPlanType {
    return Resource(
        url: ApiEndpoint.selectVisatype+"?id="+selectedCountryId,
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
            applyVisaFirstStepModel=ApplyVisaFirstStepModel.fromJson(json.decode(response.body));
            visaFirstStepList.addAll(applyVisaFirstStepModel.data!);

            return applyVisaFirstStepModelFromJson(response.body);
          } else {
            loader.value=false;
            return applyVisaFirstStepModelFromJson(response.body);
          }
        });
  }

}