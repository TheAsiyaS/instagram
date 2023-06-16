import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class phoneNumberGet extends StatelessWidget {
  const phoneNumberGet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          h30,
          IntlPhoneField(
            //controller: phonNoController,
            decoration: const InputDecoration(
                hintText: 'Phone Number',
                border: OutlineInputBorder(),
                fillColor: Color.fromARGB(255, 90, 88, 88),
                filled: true),
            onSubmitted: (PhoneNumber) {
              log("PhoneNumber-----$PhoneNumber");
              if (PhoneNumber.isEmpty) {
                return;
              } else {}
            },
          ),
          const Text(
            'You may recieve SMS Notification from us for security and login purposes',
            style: TextStyle(color: kGrey),
          ),
          h20,
          Elevated_button(
              elevatedbutttonwidget: const Text('Next'),
              elevatedbutttonid: 'PhoneNumberGet',
              elevatedbuttonstyle: ElevatedButton.styleFrom()),
          Flexible(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
