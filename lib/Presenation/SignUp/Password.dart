import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class passwordGet extends StatelessWidget {
  const passwordGet({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isTouch = ValueNotifier(false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: size.width / 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Create Password',
              style: TextStyle(fontSize: 30),
            ),
            sizedBoxHeight10,
            const Text(
              'For security, your password must be six \ncharacters or more',
              style: TextStyle(color: kGrey),
            ),
            sizedBoxHeight10,
            SizedBox(
              height: 50,
              child: CupertinotextField(
                   maxLength: 30,
                  backgroundColour: kTransparent,
                  placeholderText: 'Password..',
                  borderRadiusValue: 10,
                  borderWidthValue: 1,
                  borderColor: kGrey,
                  controller: passwordController,
                  textfieldId: 'PasswordGet',
                  placeholderStyle: const TextStyle(color: kGrey),
                  prefixWidget: sizedBoxWidth2,
                  suffixWidget: sizedBoxWidth2,
                  keyboardInputType: TextInputType.name,
                  isObscure: false),
            ),
            sizedBoxHeight10,
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isTouch,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return IconButton(
                        onPressed: () {
                          log(username);
                          log(passwordController.text);
                          isTouch.value = !isTouch.value;
                        },
                        icon: Icon(
                          isTouch.value
                              ? Icons.check_box_outline_blank
                              : Icons.check_box,
                          color: isTouch.value ? kWhite : kBlue,
                        ));
                  },
                ),
                const Text('Remeber password')
              ],
            ),
            Elevated_button(
              elevatedbuttonstyle: ElevatedButton.styleFrom(),
              elevatedbutttonwidget: const Text('Next'),
              elevatedbutttonid: 'PasswordGet',
              password: passwordController.text,
              username: username,
            ),
          ],
        ),
      ),
    );
  }
}
/*

return Scaffold(
      body: SafeArea(
          child: passwordExtraWidget(
        username: username,
        screenSubTitle:
            'For security, your password must be six \ncharacters or more',
        Screentitle: '  Create a Password ',
        ScreenextraText: 'Remeber password',
      )),
    );
 */