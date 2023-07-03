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

ValueNotifier<String> name = ValueNotifier(currentuserdata.name );
ValueNotifier<String> editeusername = ValueNotifier(currentuserdata.username);
ValueNotifier<String> newusername = ValueNotifier(currentuserdata.username);
ValueNotifier<String> bio = ValueNotifier(currentuserdata.bio);
ValueNotifier<String> newname = ValueNotifier(currentuserdata.name );
ValueNotifier<String> newbio = ValueNotifier(currentuserdata.bio);
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditprofileState();
}

class _EditprofileState extends State<EditProfile> {
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
                color: kBlue,
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
                      color: kWhite,
                    )
                  : sizedBoxHeight10,
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
              maxLength: 20,
              placeholderText: newname.value,
              borderRadiusValue: 0,
              borderWidthValue: 0,
              borderColor: kTransparent,
              controller: namecontroller,
              textfieldId: 'name_edite_profile',
              placeholderStyle: const TextStyle(color: kWhite),
              prefixWidget: sizedBoxHeight10,
              suffixWidget: sizedBoxWidth2,
              keyboardInputType: TextInputType.name,
              isObscure: false,
              backgroundColour: kTransparent),
          const Divider(
            thickness: 1,
            color: kLightWhite,
          ),
          sizedBoxHeight20,
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Username',
              style: TextStyle(color: kGrey),
            ),
          ),
          Cupertino_textfield(
              maxLength: 20,
              placeholderText: editeusername.value,
              borderRadiusValue: 0,
              borderWidthValue: 0,
              borderColor: kTransparent,
              controller: namecontroller,
              textfieldId: 'username_edite_profile',
              placeholderStyle: const TextStyle(color: kWhite),
              prefixWidget: sizedBoxHeight10,
              suffixWidget: sizedBoxWidth2,
              keyboardInputType: TextInputType.name,
              isObscure: false,
              backgroundColour: kTransparent),
          const Divider(
            thickness: 1,
            color: kLightWhite,
          ),
          sizedBoxHeight20,
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Bio',
              style: TextStyle(color: kGrey),
            ),
          ),
          Cupertino_textfield(
              maxLength: 120,
              placeholderText: bio.value,
              borderRadiusValue: 0,
              borderWidthValue: 0,
              borderColor: kTransparent,
              controller: namecontroller,
              textfieldId: 'bio_edite_profile',
              placeholderStyle: const TextStyle(color: kWhite),
              prefixWidget: sizedBoxHeight10,
              suffixWidget: sizedBoxWidth2,
              keyboardInputType: TextInputType.name,
              isObscure: false,
              backgroundColour: kTransparent),
          const Divider(
            thickness: 1,
            color: kLightWhite,
          ),
        ],
      )),
    );
  }
}