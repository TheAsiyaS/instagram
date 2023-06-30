import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Presenation/Login/Login_scree.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/variables.dart';

class CupertinotextField extends StatelessWidget {
  const CupertinotextField({
    Key? key,
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
  }) : super(key: key);

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

  void handleSubmitted(String value) {
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
    }
  }

  void handleChanged(String value) {
    if (textfieldId == 'PasswordGet') {
      passwordController.text = value;
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
    }
  }

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
      onSubmitted: handleSubmitted,
      onChanged: handleChanged,
    );
  }
}
