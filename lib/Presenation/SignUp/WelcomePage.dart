import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/Presenation/widget/TextButton.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);

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
            h10,
            const Text(
              'we\'ll add the email address and phone number from ExtendedUser to Username.You can update this info at any time in your setting or enter new info now.',
              style: TextStyle(color: kGrey),
            ),
            h30,
            Elevated_button(
                elevatedbutttonwidget: const Text('Complete Sign-Up'),
                elevatedbutttonid: 'SignUp_complete',
                elevatedbuttonstyle: ElevatedButton.styleFrom()),
            h10,                      
            Textbutton(
                textbuttonwidget:
                    const Text('Add new Phone Number or Email Addrress'),
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
                        TextButton.styleFrom(foregroundColor: kwhite)),
                Textbutton(
                    textbuttonwidget: const Text('Privacy'),
                    textbuttonid: 'privacy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kwhite)),
                Textbutton(
                    textbuttonwidget: const Text('Policy'),
                    textbuttonid: 'policy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kwhite)),
                const Text('and'),
                Textbutton(
                    textbuttonwidget: const Text('Cookie Policy'),
                    textbuttonid: 'cookie_policy',
                    textbuttonstyle:
                        TextButton.styleFrom(foregroundColor: kwhite)),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
