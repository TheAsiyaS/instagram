import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Domain/imagePick.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

import '../../utenslis/variables.dart';



class Editeprofile extends StatefulWidget {
  const Editeprofile({super.key});

  @override
  State<Editeprofile> createState() => _EditeprofileState();
}

class _EditeprofileState extends State<Editeprofile> {
  bool isImage = false;
  bool isLoading = false;
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

  final String isImageget = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Iconbuttons(
              icon: const Icon(
                kcheck,
                color: kblue,
                size: 30,
              ),
              iconId: 'check_in_edite',
              style: IconButton.styleFrom())
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await selectImage();
              final url = await AuthMethod()
                  .addProfilePic(file: image!, uid: currentuserdata.uid);
              setState(() {
                profile.value = url;
              });
              setState(() {
                isLoading = false;
              });
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profile.value),
              child: isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kwhite,
                    )
                  : h10,
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
              placeholderText: newname.value,
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
              placeholderText: editeusername.value,
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
              placeholderText: bio.value,
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
