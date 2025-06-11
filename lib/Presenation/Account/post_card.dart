
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/PostListPage.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.data,
    required this.postdata, required this.index,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  final postdata;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostListPage(
              posts: postdata,
              initialPostIndex: index,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              data['postUrl'],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Color.fromARGB(data['filterColor'][0], data['filterColor'][1], data['filterColor'][2], data['filterColor'][3]),
        ),
      ),
    );
  }
}
