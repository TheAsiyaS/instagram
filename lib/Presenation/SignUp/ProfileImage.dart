import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/AddUser.dart';
import 'package:instagram_clone/Domain/imagePick.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/Presenation/SignUp/AddFacebookfriends.dart';
import 'package:instagram_clone/Presenation/widget/TextButton.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

bool? isProfile;

class addProfilePic extends StatefulWidget {
  const addProfilePic({Key? key}) : super(key: key);

  @override
  State<addProfilePic> createState() => _addProfilePicState();
}

class _addProfilePicState extends State<addProfilePic> {
  Uint8List? im;
  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);

    setState(() {
      im = img;
      if (img != null) {
        isProfile = true;
      } else {
        isProfile = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('-------$im---------');
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            im != null
                ? CircleAvatar(
                    backgroundImage: MemoryImage(im!),
                    radius: 50,
                  )
                : const TwoIcons(
                    baseIcon: Icons.circle_outlined,
                    frondIcon: Icons.camera_enhance_outlined),
            const Text('Add Profile Photo'),
            const Text(
              'Add a profile photo \nso that your friends can konw\'s it\'s you',
              style: TextStyle(color: kGrey),
            ),
            h20,
            ElevatedButton(
                onPressed: () async {
                  await selectImage();
                  await AuthMethod().addProfilePic(file: im!);
                  currentuserdata = await AuthMethod().getUserDetail();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const NavigationPage()),
                      (route) => false);
                },
                child: const Text('Add Photo')),
            h10,
            Textbutton(
                textbuttonwidget: const Text('Skip'),
                textbuttonid: '',
                textbuttonstyle: TextButton.styleFrom()),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      )),
    );
  }
}
