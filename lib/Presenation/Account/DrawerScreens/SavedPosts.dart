import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/post.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('post')
                  .where('postId', whereIn: currentuserdata!.savePosts)
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
                  return const Center(child: Text('No Saved post !!'));
                } else {
                  return GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2.5,
                    crossAxisSpacing: 2.5,
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                      final data = snapshot.data!.docs[index];

                      return Post(
                          data: data,
                          postdata: snapshot.data!.docs,
                          index: index);
                    }),
                  );
                }
              })),
    );
  }
}
