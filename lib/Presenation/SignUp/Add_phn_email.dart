import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/EmailGet.dart';
import 'package:instagram_clone/Presenation/SignUp/subscreen/phoneNumber.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

class AddEmailPhoneNumber extends StatelessWidget {
  const AddEmailPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
        
          titleSpacing: 20,
          title: const Text(
            'Add Phone Numner or \nE-mail Addrress',
            style: TextStyle(fontSize: 25),
          ),
          bottom: const TabBar(
              isScrollable: true,
              labelColor: kwhite,
              unselectedLabelColor: kGrey,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              tabs: [
                Tab(
                  text: 'Phone Number ',
                ),
                Tab(
                  text: 'Email Addrress ',
                )
              ]),
        ),
        body: const TabBarView(children: [phoneNumberGet(), EmailGet()]),
      ),
    );
  }
}
