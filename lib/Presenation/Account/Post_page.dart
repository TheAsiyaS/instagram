import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/post.dart';

import '../../utenslis/Colors.dart';

class Postpage extends StatelessWidget {
  const Postpage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("post")
          .where('uid', isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: kWhite,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Some Error occurred'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No posts yet!!',
              style: TextStyle(fontSize: 30),
            ),
          );
        } else {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: List.generate(snapshot.data!.docs.length, (index) {
              final data = snapshot.data!.docs[index];
              String colorString = data['filterColor'];
              String extractedCode =
                  colorString.substring(6, colorString.length - 1);
              final parsedCode = int.parse(extractedCode);
              return Post(
                data: data,
                parsedCode: parsedCode,
                postdata: snapshot.data!.docs,
                index: index,
              );
            }),
          );
        }
      },
    );
  }
}
