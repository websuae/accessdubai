import 'dart:convert';

import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/FAQModule/model/faqModel.dart';
import 'package:visa_app/ui/whyUsModule/model/whyUsModel.dart';

import '../../../webservice.dart';

class WhyUsController extends GetxController {
  var loader=false.obs;
  WhyUsResponse whyUsResponse=WhyUsResponse();

  whyUsApi() {
    loader.value = true;

    Webservice().loadGET(getWhyUs).then(
          (model) => {
        print("name is::" + model.data![0].pageContent.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<WhyUsResponse> get getWhyUs {
    return Resource(
        url: ApiEndpoint.whyUs,
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
            whyUsResponse=WhyUsResponse.fromJson(json.decode(response.body));
            return whyUsResponseFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("oooopss", message);
            return whyUsResponseFromJson(response.body);
          }
        });
  }
}