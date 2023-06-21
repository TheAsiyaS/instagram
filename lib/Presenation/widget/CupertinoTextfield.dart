import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Presenation/SignUp/Username_get.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

class Cupertino_textfield extends StatelessWidget {
  const Cupertino_textfield(
      {super.key,
      required this.placeholderText,
      required this.borderradiusValue,
      required this.borderwidthValue,
      required this.borderColor,
      required this.controller,
      required this.textfieldId,
      required this.placeholderStyle,
      required this.prefixWidget,
      required this.suffixWidget,
      required this.keyboardInputTyoe,
      required this.isobscure,
      required this.backgroundcolour});
  final String placeholderText;
  final double borderradiusValue;
  final double borderwidthValue;
  final Color borderColor;
  final TextEditingController controller;
  final String textfieldId;
  final TextStyle placeholderStyle;
  final Widget prefixWidget;
  final Widget suffixWidget;
  final TextInputType keyboardInputTyoe;
  final bool isobscure;
  final Color backgroundcolour;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholderText,
      placeholderStyle: placeholderStyle,
      prefix: prefixWidget,
      suffix: suffixWidget,
      obscureText: isobscure,
      keyboardType: keyboardInputTyoe,
      style: const TextStyle(color: kwhite),
      decoration: BoxDecoration(
        color: backgroundcolour,
        borderRadius: BorderRadius.circular(borderradiusValue),
        border: Border.all(
          color: borderColor,
          width: borderwidthValue,
        ),
      ),
      onSubmitted: (value) {
        if (textfieldId == 'PasswordGet') {
          passwordController.text = value;
        } else if (textfieldId == 'UsernameGet') {
          UsernameController.text = value;
        }
      },
      onChanged: (value) {
        if (textfieldId == 'PasswordGet') {
          passwordController.text = value;
        } else if (textfieldId == 'UsernameGet') {
          UsernameController.text = value;
        }
      },
    );
  }
}
