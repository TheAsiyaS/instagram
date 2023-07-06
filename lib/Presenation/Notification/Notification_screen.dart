import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/main.dart';
// import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<DocumentSnapshot>> documents = ValueNotifier([]);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Activity'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('post')
            .where('uid', isEqualTo: '4z1oO4mSa2dYyIKjZN18rldUsMx1')
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Text('Error: ${snapshots.error}');
          } else if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No posts found.'));
          } else {
            List<dynamic> allLikes = [];

            snapshots.data!.docs.forEach((postDoc) {
              Map<String, dynamic>? postData =
                  postDoc.data() as Map<String, dynamic>?;
              List<dynamic>? likes = postData?.containsKey('likes') == true
                  ? postData!['likes'] as List<dynamic>?
                  : [];
              if (likes != null) {
                allLikes.addAll(likes);
              }
            });
            log('data length ${allLikes}');
            return allLikes.isEmpty
                ? const Center(child: Text('No activity'))
                : FutureBuilder(
                    future: fetchDataFromFirebase(allLikes),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Some Error Occurred!'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No activity'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        documents.value.addAll(snapshot.data!);
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            final postdata = snapshots.data!.docs[index];
                            log(documents.value[index]['username']);
                            return Column(
                              children: [
                                sizedBoxHeight10,
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(data['photoUrl']),
                                  ),
                                  title: RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                          text: data['username'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: "  Like your post",
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              postdata['postUrl'],
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                sizedBoxHeight10,
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: kGrey,
                            );
                          },
                        );
                      }
                    },
                  );
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchDataFromFirebase(
      List<dynamic> dataList) async {
    List<DocumentSnapshot> documents = [];

    // Fetch data from Firebase based on the UIDs in the list
    for (String uid in dataList) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: uid)
          .get();

      documents.addAll(snapshot.docs);
    }

    return documents;
  }
}
