import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/utenslis/variables.dart';
import '../../main.dart';

final TextEditingController commentController = TextEditingController();

class commentScreen extends StatelessWidget {
  const commentScreen(
      {super.key,
      this.ProfileUrl,
      this.Username,
      this.description,
      this.date,
      this.uid,
      this.postId});
  final ProfileUrl;
  final Username;
  final description;
  final date;
  final postId;
  final uid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log('profile : $ProfileUrl \nusername: $Username \ndescription :  $description \ndate : $date \n post id: $postId \n uid: $uid');
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Comments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width > websize ? size.width / 5 : 0),
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Container(
                        height: size.height / 4.5,
                        child: commets(
                          likeText: '',
                          postId: postId,
                          size: size,
                          ProfileUrl: ProfileUrl,
                          Username: Username,
                          description: description,
                          date: date,
                          bottomPadiing: 60.0,
                          NoOflikes: '',
                          suffixtext: 'Edited',
                          bottomPadding: 60.0,
                        ),
                      ),
                      const Divider(
                        color: kwhite,
                      ),
                      Expanded(
                        flex: 10,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('post')
                                .doc(postId)
                                .collection('comment')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: kwhite,
                                    strokeWidth: 2,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Some error occured');
                              } else if (snapshot.data!.docs.isEmpty) {
                                print(snapshot.data!.docs.length);
                                return const Center(
                                    child: Text(
                                  'No comment yet!!',
                                  style: TextStyle(color: kGrey, fontSize: 30),
                                ));
                              }
                              var data;
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    data = snapshot.data!.docs[index];
                                    return SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: commets(
                                          likeText: 'Like',
                                          size: size,
                                          ProfileUrl: data['ProfileImage'],
                                          Username: data['username'],
                                          description: data['comment'],
                                          date: data['datePublished'],
                                          postId: data['postId'],
                                          suffixtext: 'Reply',
                                          bottomPadding: 0.0,
                                          NoOflikes: '0'),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return h50;
                                  },
                                  itemCount: snapshot.data!.docs.length);
                            }),
                      )
                    ],
                  )),
              addComment(postId: postId, date: date)
            ],
          ),
        )));
  }
}

class addComment extends StatelessWidget {
  const addComment({
    Key? key,
    required this.postId,
    required this.date,
  }) : super(key: key);

  final postId;
  final date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: const Color.fromARGB(255, 44, 44, 44),
        child: Row(children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              currentuserdata.photoUrl ?? noimg,
            ),
          ),
          w10,
          Expanded(
            child: TextFormField(
              controller: commentController,
              decoration: const InputDecoration(hintText: 'Add a comment...'),
            ),
          ),
          TextButton(
              onPressed: () async {
                final res = await firestoreMethods().Uploadcomment(
                  commentController.text,
                  currentuserdata.username,
                  currentuserdata.photoUrl ?? noimg,
                  postId,
                  currentuserdata.uid!,
                  date,
                );

                if (res == true) {
                  commentController.text = '';
                }
              },
              child: const Text('Post'))
        ]),
      ),
    );
  }
}

class commets extends StatelessWidget {
  const commets({
    Key? key,
    required this.size,
    required this.ProfileUrl,
    required this.Username,
    required this.description,
    required this.date,
    this.bottomPadiing,
    required this.postId,
    required this.suffixtext,
    required this.NoOflikes,
    this.bottomPadding,
    required this.likeText,
  }) : super(key: key);

  final Size size;
  final ProfileUrl;
  final Username;
  final description;
  final date;
  final bottomPadiing;
  final postId;
  final String suffixtext;
  final String NoOflikes;
  final bottomPadding;
  final String likeText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,  
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                ProfileUrl,
              ),
              radius: 25,
            ),
            w10, 
            Expanded(
              child: RichText(
                maxLines: 3, 
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: Username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: " ${description}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width / 6),
              child: Text(
                '$date',
                style: const TextStyle(color: kGrey),
              ),
            ),
            w10,
            Text(
              "$NoOflikes $likeText",
              style: const TextStyle(color: kGrey),
            ),
            w10,
            Text(
              suffixtext,
              style: const TextStyle(color: kGrey),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_outline))
          ],
        ),
      ],
    );
  }
}
/*
1.make Model for comment
2.Func for storing comment

Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size.
This is considered an error condition because it indicates that there is content that cannot be seen. If the content is legitimately bigger than the available space, consider clipping it with a ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex, like a ListView.
 */




