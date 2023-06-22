import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/AddUser.dart';
import 'package:instagram_clone/Domain/imagePick.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

String profile = currentuserdata.photoUrl ??
    'https://selvamtech.edu.in/wp-content/uploads/2014/05/no-user-image.gif';

ValueNotifier<String> name = ValueNotifier(currentuserdata.name ?? "");
ValueNotifier<String> username = ValueNotifier(currentuserdata.username);
ValueNotifier<String> bio = ValueNotifier(currentuserdata.bio);

class Editeprofile extends StatefulWidget {
  const Editeprofile({super.key});

  @override
  State<Editeprofile> createState() => _EditeprofileState();
}

class _EditeprofileState extends State<Editeprofile> {
  bool? isImage;
  final TextEditingController namecontroller = TextEditingController();
  Uint8List? image;
  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);

    setState(() {
      image = img;
      if (img != null) {
        isImage = true;
      } else {
        isImage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await selectImage();
              final url = await AuthMethod()
                  .addProfilePic(file: image!, uid: currentuserdata.uid);
              setState(() {
                profile = url;
              });
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profile),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Name',
              style: TextStyle(color: kGrey),
            ),
          ),
          Cupertino_textfield(
            maxlengh: 20,
              placeholderText: currentuserdata.name ?? '',
              borderradiusValue: 0,
              borderwidthValue: 0,
              borderColor: ktransaparent,
              controller: namecontroller,
              textfieldId: 'name_edite_profile',
              placeholderStyle: const TextStyle(color: kwhite),
              prefixWidget: h10,
              suffixWidget: w2,
              keyboardInputTyoe: TextInputType.name,
              isobscure: false,
              backgroundcolour: ktransaparent),
          const Divider(
            thickness: 1,
            color: klightwhite,
          ),
          h20,
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Username',
              style: TextStyle(color: kGrey),
            ),
          ),
          Cupertino_textfield(
               maxlengh: 20,
              placeholderText: currentuserdata.username,
              borderradiusValue: 0,
              borderwidthValue: 0,
              borderColor: ktransaparent,
              controller: namecontroller,
              textfieldId: 'username_edite_profile',
              placeholderStyle: const TextStyle(color: kwhite),
              prefixWidget: h10,
              suffixWidget: w2,
              keyboardInputTyoe: TextInputType.name,
              isobscure: false,
              backgroundcolour: ktransaparent),
          const Divider(
            thickness: 1,
            color: klightwhite,
          ),
          h20,
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Bio',
              style: TextStyle(color: kGrey),
            ),
          ),
          Cupertino_textfield(
               maxlengh: 120,
              placeholderText: currentuserdata.bio,
              borderradiusValue: 0,
              borderwidthValue: 0,
              borderColor: ktransaparent,
              controller: namecontroller,
              textfieldId: 'bio_edite_profile',
              placeholderStyle: const TextStyle(color: kwhite),
              prefixWidget: h10,
              suffixWidget: w2,
              keyboardInputTyoe: TextInputType.name,
              isobscure: false,
              backgroundcolour: ktransaparent),
          const Divider(
            thickness: 1,
            color: klightwhite,
          ),
        ],
      )),
    );
  }
}
