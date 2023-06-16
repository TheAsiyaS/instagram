import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/passwordextraWidget.dart';



class passwordGet extends StatelessWidget {
  passwordGet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: SafeArea(
          child: passwordExtraWidget(
        screenSubTitle:
            'For security, your password must be six \ncharacters or more',
        Screentitle: '  Create a Password ',
        ScreenextraText: 'Remeber password',
      )),
    );
  }
}
