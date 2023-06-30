import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

final TextEditingController EmailContoller = TextEditingController();
ValueNotifier<String> gemail = ValueNotifier('');

class EmailGet extends StatelessWidget {
  const EmailGet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          sizedBoxHeight10,
          SizedBox(
            height: 50,
            child: CupertinotextField(
                 maxLength: 30,
              backgroundColour: kTransparentGrey,
                placeholderText: 'E-mail adress...',
                borderRadiusValue: 10,
                borderWidthValue: 2,
                borderColor: kTransparent,
                controller: EmailContoller,
                textfieldId: 'emailGet',
                placeholderStyle: const TextStyle(color: kGrey),
                prefixWidget: sizedBoxHeight10,
                suffixWidget: sizedBoxWidth2,
                keyboardInputType: TextInputType.emailAddress,
                isObscure: false),
          ),
          sizedBoxHeight20,
          Elevated_button(
              elevatedbutttonwidget: const Text('Next'),
              elevatedbutttonid: 'NextEmailGet',
              elevatedbuttonstyle: ElevatedButton.styleFrom())
        ],
      ),
    );
  }
}
