import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/Account/Edite_profile.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/Presenation/SignUp/WelcomePage.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/phoneNumber.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';

// ignore: camel_case_types, must_be_immutable
class Elevated_button extends StatelessWidget {
  Elevated_button(
      {super.key,
      required this.elevatedbutttonwidget,
      required this.elevatedbutttonid,
      required this.elevatedbuttonstyle,
      this.password,
      this.username, this.uid});
  final Widget elevatedbutttonwidget;
  final String elevatedbutttonid;
  final ButtonStyle elevatedbuttonstyle;
  String? username;
  String? password;
  String? uid;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (elevatedbutttonid == 'PasswordGet') {
          if (passwordController.text.length < 6) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: kRed,
                content: SnackbarWidget(
                    icon: Icons.add, message: 'Password must be 6 character')));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    welcome(username: username!, password: password!))));
          }
        } else if (elevatedbutttonid == 'NextEmailGet') {
          //EmailContoller
          if (!EmailContoller.text.contains('@gmail.com')) {
            gemail.value = 'Incorrect email';
            log('Incorrect');
            log('email${EmailContoller.text}');
          } else if (EmailContoller.text.isEmpty) {
            gemail.value = 'email adress is empty';
            log('empty');
          }

          //else if(){}
          else {
            gemail.value = EmailContoller.text;
            log(EmailContoller.text);
            Navigator.of(context).pop();
          }
        } else if (elevatedbutttonid == 'SignUp_complete') {
          if (gphonenumber.value == 'Incorrect Phone number' ||
              gphonenumber.value == '') {
            log('ph');
          } else if (gemail.value == 'Incorrect email' &&
                  gemail.value == 'email adress is empty' ||
              gemail.value == '') {
            log('em');
          } else {
            await AuthMethod().signUp(
              bio: 'Flutter Dev..',
              email: EmailContoller.text,
              password: password!,
              phoneNo: gphonenumber.value,
              username: username!,
            );
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const NavigationPage())));
          }
        } else if (elevatedbutttonid == 'PhoneNumberGet') {
          if (gphonenumber.value == 'Incorrect Phone number') {
            return;
          } else {
            Navigator.of(context).pop();
          }
        } else if (elevatedbutttonid == 'editprofile_inaccount') {
          log('message');
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const EditProfile())));
        } else if (elevatedbutttonid == 'follow_inaccount') {
          await FirestoreMethods().followUser(
            FirebaseAuth.instance.currentUser!.uid,uid!
          );
        }
      },
      style: elevatedbuttonstyle,
      child: elevatedbutttonwidget,
    );
  }
}
/*
if (!EmailContoller.text.contains('@gmail.com')) {
            gemail.value = 'Incorrect email';
            log('Incorrect');
          } else if (EmailContoller.text.isEmpty) {
            gemail.value = 'email adress is empty';
            log('empty');
          } else {
            Navigator.of(context).pop();
          }
is this correct */