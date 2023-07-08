import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:intl/intl.dart';

class PostListPage extends StatefulWidget {
  final List<QueryDocumentSnapshot> posts;
  final int initialPostIndex;

  const PostListPage({required this.posts, required this.initialPostIndex});

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialPost();
    });
  }

  void _scrollToInitialPost() {
    final postIndex = widget.initialPostIndex;

    if (postIndex >= 0 && postIndex < widget.posts.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          postIndex * 500.0, // Adjust the value as needed
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final ValueNotifier<int> profilecommentLength = ValueNotifier(0);
    final ValueNotifier<List> profilelikes = ValueNotifier([]);
    final ValueNotifier<List> savepost =
        ValueNotifier(currentuserdata.savePosts);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      savepost.value = currentuserdata.savePosts;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.separated(
        controller: _scrollController, 
        itemBuilder: (context, index) {
          final post = widget.posts[index];
          ValueNotifier<String> formattedDate =
              ValueNotifier(post['datePublished']);
          String? datePublish = post['datePublished'];
          profilelikes.value = post['likes'];
          if (datePublish != null) {
            DateTime myDate = DateTime.parse(datePublish);
            formattedDate.value = DateFormat('dd-MM-yyyy').format(myDate);
          } else {}

          final finaldate = formattedDate.value.split(' ');

          String colorString = post['filterColor'];
          String extractedCode =
              colorString.substring(6, colorString.length - 1);
          final parscode = int.parse(extractedCode);
          final ValueNotifier<bool> issave =
              ValueNotifier(currentuserdata.savePosts.contains(post['postId']));
          return SizedBox(
            height: size.height / 1.24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height / 12,
                  width: size.width,
                  //color: kRed,
                  child: Row(
                    children: [
                      sizedBoxWidth10,
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(post['profileImage']),
                      ),
                      sizedBoxWidth10,
                      Text(
                        post['username'],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: '1',
                              child: Text('Edite'),
                            ),
                            const PopupMenuItem<String>(
                              value: '2',
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<String>(
                              value: '3',
                              child: Text('Archive'),
                            ),
                          ];
                        },
                        onSelected: (String value) async {
                          if (value == '1') {
                          } else if (value == '2') {
                            await FirestoreMethods().deletePost(post['postId']);
                          } else if (value == '3') {}
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height / 2,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        post['postUrl'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: size.height / 2,
                    width: size.width,
                    color: Color(parscode),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Iconbuttons(
                            icon: const Icon(
                              kaccountcircle,
                              color: kBlack,
                              size: 32,
                            ),
                            taguid: post['tag'],
                            iconId: 'tag_persons',
                            style: IconButton.styleFrom()),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Iconbuttons(
                      icon: profilelikes.value.contains(currentuserdata.uid)
                          ? const Icon(
                              kfavorite,
                              size: 29,
                              color: kRed,
                            )
                          : const Icon(
                              kfavorite_outline,
                              size: 29,
                            ),
                      postid: post['postId'],
                      likes: profilelikes.value,
                      iconId: 'fav_out_in_post',
                      style: IconButton.styleFrom(),
                    ),
                    Iconbuttons(
                      icon: const Icon(
                        kcomment,
                        size: 28,
                      ),
                      iconId: 'cmt_out_in_post',
                      likes: profilelikes.value,
                      postid: post['postId'],
                      date: formattedDate.value,
                      description: post['description'],
                      profileimg: post['profileImage'],
                      uid: post['uid'],
                      username: post['username'],
                      style: IconButton.styleFrom(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 9,
                      ),
                      child: Iconbuttons(
                        icon: Transform.rotate(
                          angle: -20 * pi / 180,
                          child: const Icon(
                            kshare,
                            size: 28,
                          ),
                        ),
                        iconId: 'snd_in_post',
                        style: IconButton.styleFrom(),
                      ),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                        valueListenable: issave,
                        builder: (context, value, _) {
                          return IconButton(
                            onPressed: () async {
                              if (currentuserdata.savePosts
                                  .contains(post['postId'])) {
                                savepost.value.remove(post['postId']);
                                issave.value = false;
                                savepost.notifyListeners();
                              } else {
                                issave.value = true;
                                savepost.value.add(post['postId']);
                                savepost.notifyListeners();
                              }

                              await AuthMethod().updateSavepots(
                                  postId: post['postId']!,
                                  uid: currentuserdata.uid!);
                              print('${issave.value}');
                            },
                            icon: Icon(
                              issave.value ? ksaved : ksave,
                              size: 28,
                            ),
                          );
                        })
                  ],
                ),
                Text(
                  ' ${profilelikes.value.length} likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: post['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: " ${post['description']}",
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('post')
                      .doc(post['postId'])
                      .collection('comment')
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
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      profilecommentLength.value = 0;
                    }

                    profilecommentLength.value = snapshot.data!.docs.length;

                    return Text(
                      'View all ${profilecommentLength.value} comments',
                      style: const TextStyle(
                        color: kGrey,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                Text(
                  ' ${finaldate[0]}',
                  style: const TextStyle(
                    color: kGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: kGrey,
          );
        },
        itemCount: widget.posts.length,
      ),
    );
  }
}
