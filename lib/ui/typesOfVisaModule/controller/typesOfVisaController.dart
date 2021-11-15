import 'dart:convert';
import 'package:get/get.dart';
import 'package:visa_app/service/ApiEndPoint.dart';
import 'package:visa_app/ui/typesOfVisaModule/model/typesOfVisaModel.dart';
import '../../../webservice.dart';

class TypesOfVisaController extends GetxController {
  var loader=false.obs;
  //List<Datum> visaTypeList= [];
  var visaTypeList= [].obs ;
  late TypesOfVisa abc;

  typesOfVisaApi() {
    loader.value = true;
    Map<String, dynamic> map = Map<String, dynamic>();

    Webservice().loadPost(getVisaType, map).then(
          (model) => {
        print("name is::" + model.message.toString()),
        if (model.status == true) {
        } else {}
      },
    );
  }

  Resource<TypesOfVisa> get getVisaType {
    return Resource(
        url: ApiEndpoint.visaType,
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
             abc=TypesOfVisa.fromJson(json.decode(response.body));
            visaTypeList.addAll(abc.data!);

            return typesOfVisaFromJson(response.body);
          } else {
            loader.value=false;
            String message = result["message"];
            Get.snackbar("oooopss", message);
            return typesOfVisaFromJson(response.body);
          }
        });
  }
}