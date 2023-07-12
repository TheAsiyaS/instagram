import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

final TextEditingController editeDescription = TextEditingController();

class EditingPost extends StatelessWidget {
  const EditingPost({Key? key, required this.postdata}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> postdata;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          IconButton(
            onPressed: () async {
              if (editeDescription.text.isNotEmpty) {
                await FirestoreMethods().updateDescription(
                  description: editeDescription.text,
                  uid: postdata['postId'],
                );
              } else {
                log('error------------------------');
              }

              Navigator.of(context).pop();
            },
            icon: const Icon(
              kcheck,
              color: kBlue,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height / 2,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(postdata['postUrl']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            sizedBoxHeight20,
            SizedBox(
                height: size.height / 9,
                child: Cupertino_textfield(
                    placeholderText: postdata['description'],
                    borderRadiusValue: 10,
                    borderWidthValue: .5,
                    borderColor: kTransparentGrey,
                    controller: editeDescription,
                    textfieldId: 'edite_decription',
                    placeholderStyle: const TextStyle(color: kWhite),
                    prefixWidget: sizedBoxHeight10,
                    suffixWidget: sizedBoxWidth2,
                    keyboardInputType: TextInputType.name,
                    isObscure: false,
                    backgroundColour: kTransparentGrey,
                    maxLength: 100)),
          ],
        ),
      ),
    );
  }
}
