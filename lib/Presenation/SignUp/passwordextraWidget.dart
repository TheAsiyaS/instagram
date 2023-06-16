import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

final TextEditingController passwordController = TextEditingController();

class passwordExtraWidget extends StatelessWidget {
  const passwordExtraWidget({
    Key? key,
    required this.Screentitle,
    required this.screenSubTitle,
    this.screenIcon,
    this.ScreenextraText,
    this.textButton,
  }) : super(key: key);

  final String Screentitle;
  final String screenSubTitle;
  final Icon? screenIcon;
  final String? ScreenextraText;
  final TextButton? textButton;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isTouch = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            Screentitle,
            style: const TextStyle(fontSize: 30),
          ),
          h10,
          Text(
            screenSubTitle,
            style: const TextStyle(color: kGrey),
          ),
          h10,
          SizedBox(
            height: 50,
            child: Cupertino_textfield(
                placeholderText: 'Password..',
                borderradiusValue: 10,
                borderwidthValue: 1,
                borderColor: kGrey,
                controller: passwordController,
                textfieldId: 'PasswordGet',
                placeholderStyle: const TextStyle(color: kGrey),
                prefixWidget: w2,
                suffixWidget: w2,
                keyboardInputTyoe: TextInputType.name,
                isobscure: false),
          ),
          h10,
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: isTouch,
                builder: (BuildContext context, bool value, Widget? child) {
                  return IconButton(
                      onPressed: () {
                        isTouch.value = !isTouch.value;
                      },
                      icon: Icon(
                        isTouch.value
                            ? Icons.check_box_outline_blank
                            : Icons.check_box,
                        color: isTouch.value ? kwhite : kblue,
                      ));
                },
              ),
              Text(ScreenextraText!)
            ],
          ),
          Elevated_button(
              elevatedbuttonstyle: ElevatedButton.styleFrom(),
              elevatedbutttonwidget: const Text('Next'),
              elevatedbutttonid: 'PasswordGet'),
        ],
      ),
    );
  }
}
