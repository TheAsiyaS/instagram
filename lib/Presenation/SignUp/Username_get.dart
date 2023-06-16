import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/Password.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/utenslis/Title_subtitle.dart';

class UsernameGet extends StatelessWidget {
  UsernameGet({Key? key}) : super(key: key);
  final TextEditingController UsernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
            h20,
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => passwordGet())));
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
        ),
      )),
    );
  }
}
