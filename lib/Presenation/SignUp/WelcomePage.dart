import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/SignUp/AddFacebookfriends.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/phoneNumber.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/Presenation/widget/TextButton.dart';
import 'package:instagram_clone/utenslis/styles.dart';

ValueNotifier<String> welcomepagemessage = ValueNotifier('');

class welcome extends StatelessWidget {
  const welcome({Key? key, required this.username, required this.password})
      : super(key: key);
  final String username;
  final String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Welcome to Instagram,\nUsername',
              style: TextStyle(fontSize: 30),
            ),
            sizedBoxHeight10,
            const Text(
              'we\'ll add the email address and phone number from ExtendedUser to Username.You can update this info at any time in your setting or enter new info now.',
              style: TextStyle(color: kGrey),
            ),
            sizedBoxHeight30,
            ElevatedButton(
                style: elevatedbuttonstyle,
                onPressed: () async {
                  log('username: $username password $password');
                  if (gphonenumber.value == 'Incorrect Phone number' ||
                      gphonenumber.value == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: kWhite,
                        content: SnackbarWidget(
                            icon: Icons.favorite,
                            message: 'Incorrect Phone number')));
                  } else if (gemail.value == 'Incorrect email' &&
                          gemail.value == 'email adress is empty' ||
                      gemail.value == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: kWhite,
                        content: SnackbarWidget(
                            icon: Icons.favorite, message: 'Incorrect email')));
                  } else if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: kWhite,
                        content: SnackbarWidget(
                            icon: Icons.favorite,
                            message: 'username or password is empty')));
                  } else {
                    await AuthMethod().signUp(
                      bio: '',
                      email: EmailContoller.text,
                      password: password,
                      phoneNo: gphonenumber.value,
                      username: username,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const AddFacebookFreinds())));
                  }
                },
                child: Text(
                  'Complete Sign-Up',
                  style: textstylefontwhite,
                )),
            sizedBoxHeight10,
            Textbutton(
                textbuttonwidget: Text(
                  'Add new Phone Number or Email Addrress',
                  style: TextStyle(color: kBlue),
                ),
                textbuttonid: 'addphn_email',
                textbuttonstyle: TextButton.styleFrom()),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Text('we\'ll add private info from -- to username .See '),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Textbutton(
                    textbuttonwidget: const Text('Terms'),
                    textbuttonid: 'terms',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kWhite)),
                Textbutton(
                    textbuttonwidget: const Text('Privacy'),
                    textbuttonid: 'privacy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kWhite)),
                Textbutton(
                    textbuttonwidget: const Text('Policy'),
                    textbuttonid: 'policy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kWhite)),
                const Text('and'),
                Textbutton(
                    textbuttonwidget: const Text('Cookie Policy'),
                    textbuttonid: 'cookie_policy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kWhite)),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
