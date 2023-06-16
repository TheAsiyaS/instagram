import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/Add_phn_email.dart';

class Textbutton extends StatelessWidget {
  const Textbutton(
      {super.key,
      required this.textbuttonwidget,
      required this.textbuttonid,
      required this.textbuttonstyle});
  final Widget textbuttonwidget;
  final String textbuttonid;
  final ButtonStyle textbuttonstyle;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (textbuttonid == '') {
        } else if (textbuttonid == 'addphn_email') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const AddEmailPhoneNumber())));
        }
      },
      style: textbuttonstyle,
      child: textbuttonwidget,
    );
  }
}
