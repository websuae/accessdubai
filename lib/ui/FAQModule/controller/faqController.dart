import 'dart:convert';

import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/FAQModule/model/faqModel.dart';

import '../../../webservice.dart';

class FaqController extends GetxController {
  var loader=false.obs;
  var faqList= [].obs ;
  late FaqResponse faqResponse;


  faqApi() {
    loader.value = true;
    Map<String, dynamic> map = Map<String, dynamic>();

    Webservice().loadGET(getFaq).then(
          (model) => {
        print("name is::" + model.data[1].fque.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<FaqResponse> get getFaq {
    return Resource(
        url: ApiEndpoint.faq,
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
            faqResponse=FaqResponse.fromJson(json.decode(response.body));
            faqList.addAll(faqResponse.data!);

            return faqResponseFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("oooopss", message);
            return faqResponseFromJson(response.body);
          }
        });
  }
}