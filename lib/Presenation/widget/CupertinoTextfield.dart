import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/AddUser.dart';
import 'package:instagram_clone/Presenation/Account/Edite_profile.dart';
import 'package:instagram_clone/Presenation/SignUp/Username_get.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/main.dart';
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
      required this.backgroundcolour, required this.maxlengh});
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
    final int maxlengh;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      maxLength:maxlengh ,
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
        } else if (textfieldId == 'emailGet') {
          EmailContoller.text = value;
        } else if (textfieldId == 'name_edite_profile') {
          controller.text = value;
        } else if (textfieldId == 'username_edite_profile') {
          controller.text = value;
        }
      },
      onChanged: (value) async {
        if (textfieldId == 'PasswordGet') {
          passwordController.text = value;
        } else if (textfieldId == 'UsernameGet') {
          UsernameController.text = value;
        } else if (textfieldId == 'emailGet') {
          EmailContoller.text = value;
        } else if (textfieldId == 'name_edite_profile') {
          controller.text = value;
          await AuthMethod().updateName(name: value, uid: currentuserdata.uid);
          name.value = value;
        } else if (textfieldId == 'username_edite_profile') {
          controller.text = value;
          await AuthMethod()
              .updateUsername(username: value, uid: currentuserdata.uid);
          username.value = value;
        } else if (textfieldId == 'bio_edite_profile') {
          controller.text = value;
          await AuthMethod().updateBio(bio: value, uid: currentuserdata.uid);
          bio.value = value;
        }
      },
    );
  }
}
