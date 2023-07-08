import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Presenation/Account/Edite_profile.dart';
import 'package:instagram_clone/Presenation/AddPost/Tag_post.dart';
import 'package:instagram_clone/Presenation/Login/Login_scree.dart';
import 'package:instagram_clone/Presenation/SignUp/Password.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/variables.dart';

class Cupertino_textfield extends StatelessWidget {
  const Cupertino_textfield({
    super.key,
    required this.placeholderText,
    required this.borderRadiusValue,
    required this.borderWidthValue,
    required this.borderColor,
    required this.controller,
    required this.textfieldId,
    required this.placeholderStyle,
    required this.prefixWidget,
    required this.suffixWidget,
    required this.keyboardInputType,
    required this.isObscure,
    required this.backgroundColour,
    required this.maxLength,
  });
  final String placeholderText;
  final double borderRadiusValue;
  final double borderWidthValue;
  final Color borderColor;
  final TextEditingController controller;
  final String textfieldId;
  final TextStyle placeholderStyle;
  final Widget prefixWidget;
  final Widget suffixWidget;
  final TextInputType keyboardInputType;
  final bool isObscure;
  final Color backgroundColour;
  final int maxLength;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      maxLength: maxLength,
      placeholder: placeholderText,
      placeholderStyle: placeholderStyle,
      prefix: prefixWidget,
      suffix: suffixWidget,
      obscureText: isObscure,
      keyboardType: keyboardInputType,
      style: const TextStyle(color: kWhite),
      decoration: BoxDecoration(
        color: backgroundColour,
        borderRadius: BorderRadius.circular(borderRadiusValue),
        border: Border.all(
          color: borderColor,
          width: borderWidthValue,
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
          name.value = value;
        } else if (textfieldId == 'username_edite_profile') {
          editeusername.value = value;
        } else if (textfieldId == 'bio_edite_profile') {
          bio.value = value;
        } else if (textfieldId == 'getEmailadressLogin') {
          emailAddress.text = value;
        } else if (textfieldId == 'getpasswordLogin') {
          password.text = value;
        } else if (textfieldId == 'tag_page') {
          searchUser.value = value;
        }
      },
      onChanged: (value) async {
        if (textfieldId == 'PasswordGet') {
          passwordController.text = value;
          print(value);
        } else if (textfieldId == 'UsernameGet') {
          UsernameController.text = value;
        } else if (textfieldId == 'emailGet') {
          EmailContoller.text = value;
        } else if (textfieldId == 'name_edite_profile') {
          controller.text = value;
          name.value = value;
        } else if (textfieldId == 'username_edite_profile') {
          controller.text = value;
          editeusername.value = value;
        } else if (textfieldId == 'bio_edite_profile') {
          bio.value = value;
        } else if (textfieldId == 'getEmailadressLogin') {
          emailAddress.text = value;
        } else if (textfieldId == 'getpasswordLogin') {
          password.text = value;
        } else if (textfieldId == 'tag_page') {
          searchUser.value = value;
        }
      },
    );
  } //bio_edite_profile
}
