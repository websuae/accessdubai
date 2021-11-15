import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visa_app/constants/appImages.dart';

class ChatWithUsPage extends StatefulWidget {
  const ChatWithUsPage({Key? key}) : super(key: key);

  @override
  _ChatWithUsPageState createState() => _ChatWithUsPageState();
}

class _ChatWithUsPageState extends State<ChatWithUsPage> {
  bool err = false;
  String msgErr = '';

  void whatsAppOpen() async{
    var whatsapp ="+917623837736";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Whatsapp",
                  ),
                  err ? Text(msgErr) : const Text('')
                ],
              ),
              onPressed: () {
                whatsAppOpen();
              },
            )),
      ),
    );
  }
}
