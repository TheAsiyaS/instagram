import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/AddUser.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/Presenation/SignUp/Username_get.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

const websize = 600;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize > websize
                ? MediaQuery.of(context).size.width / 3
                : 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Text('Instagram',
                style: GoogleFonts.grandHotel(
                  fontSize: 45,
                )),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              height: 50,
              child: Cupertino_textfield(
                  maxlengh: 30,
                  placeholderText: 'Enter your E-mail adress',
                  borderradiusValue: 5,
                  borderwidthValue: 0,
                  borderColor: ktransaparent,
                  controller: emailAddress,
                  textfieldId: 'getEmailadressLogin',
                  placeholderStyle: const TextStyle(color: kGrey),
                  prefixWidget: w2,
                  suffixWidget: w2,
                  keyboardInputTyoe: TextInputType.emailAddress,
                  isobscure: false,
                  backgroundcolour: ktransaparentGrey),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 50,
              child: Cupertino_textfield(
                  maxlengh: 30,
                  placeholderText: 'Enter your Password',
                  borderradiusValue: 5,
                  borderwidthValue: 0,
                  borderColor: ktransaparent,
                  controller: emailAddress,
                  textfieldId: 'getpasswordLogin',
                  placeholderStyle: const TextStyle(color: kGrey),
                  prefixWidget: w2,
                  suffixWidget: w2,
                  keyboardInputTyoe: TextInputType.name,
                  isobscure: false,
                  backgroundcolour: ktransaparentGrey),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                focusNode: FocusNode(),
                onPressed: () async {
                  final res = await AuthMethod().loginUser(
                      Email: emailAddress.text, Password: password.text);
                  log(res.toString());
                  if (res == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: SnackbarWidget(
                            icon: Icons.remove,
                            message: 'Something error occured !!!')));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const NavigationPage()));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forgot Login Detalis?'),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Get help with Logging in.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: kwhite),
                    )),
              ],
            ),
            const Center(child: Text('OR')),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook),
              label: const Text(
                'Log In With Facebook',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => UsernameGet())));
                    },
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: kwhite),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
