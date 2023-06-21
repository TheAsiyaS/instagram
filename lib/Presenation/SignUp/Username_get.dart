import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/Password.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/Presenation/widget/Title_subtitle.dart';
import 'package:instagram_clone/utenslis/variables.dart';

  final TextEditingController UsernameController = TextEditingController();

class UsernameGet extends StatelessWidget {
  UsernameGet({Key? key}) : super(key: key);
ValueNotifier<String> message = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
            valueListenable: message,
            builder: (context, snapshot, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  const Titlesubtitle(
                      title: 'Choose Username',
                      subtitle: 'You can change it later',
                      titlestyle: TextStyle(
                        fontSize: 30,
                      ),
                      subtitlestyle: TextStyle(color: kGrey)),
                  h20,
                  SizedBox(
                    height: 50,
                    child: Cupertino_textfield(
                      backgroundcolour: ktransaparent,
                      placeholderText: 'Username....',
                      borderradiusValue: 10,
                      borderwidthValue: 1,
                      borderColor: kGrey,
                      controller: UsernameController,
                      textfieldId: 'UsernameGet',
                      placeholderStyle: const TextStyle(color: kGrey),
                      prefixWidget: w2,
                      suffixWidget: w2,
                      keyboardInputTyoe: TextInputType.name,
                      isobscure: false,
                    ),
                  ),
                  h10,
                  Text(
                    message.value,
                    style: const TextStyle(color: kGrey),
                  ),
                  h10,
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (UsernameController.text.isEmpty) {
                          message.value = 'Entered username empty ';
                        } else if (!usernameRegex
                            .hasMatch(UsernameController.text)) {
                          message.value =
                              'Username can only include letters, numbers, underscores and full stops.';
                        } else if (UsernameController.text.length > 20) {
                          message.value = 'Maximum letters can be 20';
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => passwordGet())));
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(),
                  ),
                ],
              );
            }),
      )),
    );
  }
}
