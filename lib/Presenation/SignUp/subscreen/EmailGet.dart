import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

final TextEditingController EmailContoller = TextEditingController();

class EmailGet extends StatelessWidget {
  const EmailGet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          h10,
          SizedBox(
            height: 50,
            child: Cupertino_textfield(
                placeholderText: 'E-mail adress...',
                borderradiusValue: 10,
                borderwidthValue: 2,
                borderColor: kGrey,
                controller: EmailContoller,
                textfieldId: 'emailGet',
                placeholderStyle: const TextStyle(color: kGrey),
                prefixWidget: h10,
                suffixWidget: w2,
                keyboardInputTyoe: TextInputType.emailAddress,
                isobscure: false),
          ),
          h20,
          Elevated_button(
              elevatedbutttonwidget: const Text('Next'),
              elevatedbutttonid: 'NextEmailGet',
              elevatedbuttonstyle: ElevatedButton.styleFrom())
        ],
      ),
    );
  }
}
