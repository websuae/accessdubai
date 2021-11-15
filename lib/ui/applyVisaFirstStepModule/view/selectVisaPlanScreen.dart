import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visa_app/constants/appColor.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/constants/sharePrefConstants.dart';
import 'package:visa_app/ui/applyVisaFirstStepModule/controller/ApplyVisaFirstStepController.dart';
import 'package:visa_app/ui/applyVisaModule/view/applyVisaScreen.dart';
import 'package:visa_app/ui/signInModule/view/signInScreen.dart';
import 'package:visa_app/widget/commonAppBar.dart';

class SelectVisaPlanPage extends StatefulWidget {
  String selectedCountry="";

   SelectVisaPlanPage({Key? key,required  this.selectedCountry});

  @override
  _SelectVisaPlanPage createState() => _SelectVisaPlanPage();
}

class _SelectVisaPlanPage extends State<SelectVisaPlanPage> {
  ApplyVisaFirstStepController controller = Get.put(ApplyVisaFirstStepController());
  bool isLogins =false;


  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(isLogin)) {
      isLogins = prefs.getBool(isLogin)!;
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getBoolValuesSF();
      setState(() {

      });

    });
    print("widget id:"+widget.selectedCountry);
    controller.selectedCountryId=widget.selectedCountry;
    controller.applyVisaFirstStepApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          appBar: AppBar(),
          isLeading: true,
          isFromBottom: true,
          action: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child:Image.asset(
                new_logo,
                height: 50.h,
                width: 35.h,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.h),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 150.h,
                          autoPlay: true,
                          autoPlayInterval: Duration(milliseconds: 1500),
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                        ),
                        items: [forgotImage, signinImage].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Image.asset(
                                  "$i",
                                  fit: BoxFit.cover,
                                  height: 150.h,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: Text(
                          "Type of visa",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: colorWhite),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child:Obx(
                          () => controller.visaFirstStepList != null &&
                      controller.visaFirstStepList.length > 0
                      ?  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.visaFirstStepList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 2.5.h,bottom: 2.5.h),
                          child: Card(
                            child: Container(
                              child: Column(
                                children: [
                                  Image.network(
                                      // controller.visaFirstStepModel.imagePath! +
                                          controller.visaFirstStepList[index]
                                              .visatypeImg
                                              .toString(),
                                      height: 150.h,
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      controller.visaFirstStepList[index]
                                          .visatypeName
                                          .toString(),
                                    style: TextStyle(
                                        color: colorBlue,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                      ),
                                    child: Text(
                                        controller.visaFirstStepList[index]
                                            .visatypeSDesc
                                            .toString(),
                                      textAlign: TextAlign.center,
                                      maxLines:
                                      controller.visaFirstStepList[index].descTextShowFlag ? 35 : 3,
                                      style: TextStyle(
                                          color: colorBlack,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (int i = 0;
                                        i <
                                            controller.visaFirstStepList
                                                .length; i++) {
                                          print("index:"+index.toString());
                                          print("i:"+i.toString());
                                          if (i == index) {
                                            controller.visaFirstStepList[index].descTextShowFlag =
                                            !controller.visaFirstStepList[index].descTextShowFlag;
                                          }
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: <Widget>[
                                          controller.visaFirstStepList[index].descTextShowFlag
                                              ? Padding(
                                            padding:
                                            EdgeInsets.only(
                                                top: 20.h,
                                                bottom: 40.h),
                                            child: Container(
                                              height: 30.h,
                                              width: 140.w,
                                              color:
                                              colorLightGrey,
                                              child: Center(
                                                child: Text(
                                                  "Show Less ->",
                                                  style: TextStyle(
                                                      color:
                                                      colorBlue,
                                                      fontSize:
                                                      16.sp),
                                                ),
                                              ),
                                            ),
                                          )
                                              : Padding(
                                            padding:
                                            EdgeInsets.only(
                                                top: 20.h,
                                                bottom: 40.h),
                                            child: Container(
                                              height: 30.h,
                                              width: 140.w,
                                              color:
                                              colorLightGrey,
                                              child: Center(
                                                child: Text(
                                                  "Read More ->",
                                                  style: TextStyle(
                                                      color:
                                                      colorBlue,
                                                      fontSize:
                                                      16.sp),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text("Price",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal)),
                                      )),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Text(
                                          controller.visaFirstStepList[index]
                                              .price==null?"0":controller.visaFirstStepList[index]
                                              .price.toString()+" AED",
                                          style: TextStyle(
                                              fontSize: 22.sp,
                                              color: colorYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w, bottom: 5.h),
                                        child: Container(
                                          height: 32.h,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2.3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(isLogins){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                          (ApplyVisaPage(visatypeId: controller.visaFirstStepList[index].visatypeId,visatypeTitle:controller.visaFirstStepList[index].visatypeName ,))));
                                                }
                                                else{
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      content: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text("Alert",style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                                                          SizedBox(height: 20.h,),
                                                          Text("You need to login first\n for applying visa",style: TextStyle(color: Colors.black,fontSize: 16.sp),textAlign: TextAlign.center,),
                                                          SizedBox(height: 20.h,),
                                                          GestureDetector(
                                                            onTap: (){
                                                              Get.offAll(SignIn());
                                                            },
                                                            child: Container(
                                                              padding:
                                                              EdgeInsets.only(left: 10.w, right: 10.w),
                                                              height: 40.h,
                                                              width:
                                                              MediaQuery.of(context).size.width / 1.5,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  color: colorYellow),
                                                              child: Center(
                                                                child: Text(
                                                                  "Login",
                                                                  style: TextStyle(
                                                                      fontSize: 14.sp,
                                                                      color: colorWhite,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }

                                              });
                                            },
                                            child: Text(
                                              "Apply Now",
                                              style: TextStyle(color: colorWhite),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: colorYellow,
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }):Center(child: CircularProgressIndicator())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectIndex {
  String? value;
  String? image;
  String? value2;
  bool? isSelected;

  SelectIndex({this.value, this.image, this.value2, this.isSelected});
}
