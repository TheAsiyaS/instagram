import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/Presenation/SignUp/WelcomePage.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';

class Elevated_button extends StatelessWidget {
  const Elevated_button(
      {super.key,
      required this.elevatedbutttonwidget,
      required this.elevatedbutttonid,
      required this.elevatedbuttonstyle});
  final Widget elevatedbutttonwidget;
  final String elevatedbutttonid;
  final ButtonStyle elevatedbuttonstyle;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (elevatedbutttonid == 'PasswordGet') {
          if (passwordController.text.length < 6) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: kred,
                content: SnackbarWidget(
                    icon: Icons.add, message: 'Password must be 6 character')));
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const welcome())));
          }
        } else if (elevatedbutttonid == 'NextEmailGet') {
          Navigator.of(context).pop();
        } else if (elevatedbutttonid == 'SignUp_complete') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const NavigationPage())));
        }
      },
      style: elevatedbuttonstyle,
      child: elevatedbutttonwidget,
    );
  }
}
