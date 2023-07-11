import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class EditingPost extends StatelessWidget {
  const EditingPost({super.key, required this.postdata});
  final QueryDocumentSnapshot<Map<String, dynamic>> postdata;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final desciptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edite Post'),
        actions: [
          IconButton(
              onPressed: () async{
               await FirestoreMethods().updateDescription(
                    description: desciptionController.text,
                    uid: postdata['postId']);
              },
              icon: const Icon(
                kcheck,
                color: kBlue,
              ))
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
                    fit: BoxFit.cover)),
          ),
          sizedBoxHeight20,
          Expanded(
            child: CupertinoTextField(
              controller: desciptionController,
              maxLines: 20,
              style: const TextStyle(color: kWhite),
              placeholder: postdata['description'],
              placeholderStyle: const TextStyle(
                color: kWhite,
              ),
              onChanged: (value) {
                desciptionController.text = value;
              },
            ),
          ),
        ],
      )),
    );
  }
}
