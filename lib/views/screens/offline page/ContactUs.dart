import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contact Us'.tr,
        home: Scaffold(
          backgroundColor: const Color(0xFF0A0E21),
          appBar: AppBar(
              backgroundColor: const Color(0xFF111631),
              automaticallyImplyLeading: true,
              title: Title(
                title: 'Title',
                color: Colors.black,
                child: Text(
                  'Contact Us'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                //onPressed:() => Navigator.pop(context, false),
                onPressed: () => Navigator.pop(context),
              )),
          body: Center(
            child: Text(
              'Phone :  +963 967 184 204'.tr,
              style: const TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ));
  }
}
