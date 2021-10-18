import 'package:flutter/material.dart';
import 'package:visa_app/constants/appImages.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Image.asset(comingsoon),
          ),
        ),
      ),
    );
  }
}
