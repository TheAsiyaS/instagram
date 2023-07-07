import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/PostListPage.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

class Tagpage extends StatelessWidget {
  const Tagpage({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('post')
            .where('tag', arrayContains:uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: kWhite,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Some Error occurred'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tag post !!'));
          } else {
            return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              children: List.generate(snapshot.data!.docs.length, (index) {
                final data = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostListPage(
                          posts: snapshot.data!.docs,
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
                            fit: BoxFit.cover)),
                  ),
                );
              }),
            );
          }
        });
  }
}
