import 'dart:math' hide log;
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/Account/Others_account.dart';
import 'package:instagram_clone/Presenation/Edite/Edite_post.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class postHome extends StatelessWidget {
  const postHome(
      {super.key,
      required this.size,
      required this.data,
      required this.likes,
      required this.date,
      required this.saveby,
      required this.finaldate});
  final Size size;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final List likes;
  final String date;
  final List<String> finaldate;
  final List saveby;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> issaved =
        ValueNotifier(saveby.contains(currentuserdata!.uid));
    ValueNotifier<bool> isliked =
        ValueNotifier(likes.contains(currentuserdata!.uid));
    final ValueNotifier<List> likesNotifier =
    ValueNotifier<List>(likes);
    
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
                  backgroundImage: NetworkImage(data['profileImage']),
                ),
                sizedBoxWidth10,
                Text(
                  data['username'],
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
                      if (data['uid'] == currentuserdata!.uid) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditingPost(
                                  postdata: data,
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: kRed,
                            content: SnackbarWidget(
                                icon: kremove,
                                message:
                                    'You can\'t edit this post only user can edit ')));
                      }
                    } else if (value == '2') {
                      if (data['uid'] == currentuserdata!.uid) {
                        await FirestoreMethods().deletePost(data['postId']);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: kRed,
                            content: SnackbarWidget(
                                icon: kremove,
                                message:
                                    'You can\'t delete this post only user can delete')));
                      }
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
                  data['postUrl'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              height: size.height / 2,
              width: size.width,
              color: Color.fromARGB(
                  data['filterColor'][0],
                  data['filterColor'][1],
                  data['filterColor'][2],
                  data['filterColor'][3]),
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
                      taguid: data['tag'],
                      iconId: 'tag_persons',
                      style: IconButton.styleFrom()),
                ],
              ),
            ),
          ),
          Row(
            children: [
              LikeButton(isliked: isliked, likes: likes, data: data,likesNotifier: likesNotifier,),
              Iconbuttons(
                icon: const Icon(
                  kcomment,
                  size: 28,
                ),
                iconId: 'cmt_out_in_post',
                likes: likes,
                postid: data['postId'],
                date: date,
                description: data['description'],
                profileimg: data['profileImage'],
                uid: data['uid'],
                username: data['username'],
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
              Savebutton(issaved: issaved, saveby: saveby, data: data)
            ],
          ),
          GestureDetector(
            onTap: () async {
              if (likes.isEmpty) {
                return;
              }
              var likeData = await FirebaseFirestore.instance
                  .collection('user')
                  .where(
                    'uid',
                    whereIn: likes,
                  )
                  .get();
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  backgroundColor: kTransparentGrey,
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (BuildContext context) {
                    return likeData.docs.isEmpty
                        ? Text('This post have no likes')
                        : SizedBox(
                            width: size.width,
                            height: size.height / 3,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(data['photoUrl']),
                                  ),
                                  title: Text(data['username']),
                                  subtitle: Text(data['name']),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => OthersProfile(
                                                uid: data['uid'])));
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: kWhite,
                                );
                              },
                              itemCount: likeData.docs.length,
                            ));
                  });
            },
            child: ValueListenableBuilder(
              valueListenable: likesNotifier,
              builder: (context, value, child) {
                return Text(
                  ' ${likesNotifier.value.length} likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                );
              }
            ),
          ),
          RichText(
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
                TextSpan(
                  text: " ${data['description']}",
                ),
              ],
            ),
          ),
          // StreamBuilder<
          //     QuerySnapshot<Map<String, dynamic>>>(
          //   stream: FirebaseFirestore.instance
          //       .collection('post')
          //       .doc(data['postId'])
          //       .collection('comment')
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState ==
          //         ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           strokeWidth: 2,
          //           color: kWhite,
          //         ),
          //       );
          //     } else if (snapshot.hasError) {
          //       return const Center(
          //         child: Text('Some Error occurred'),
          //       );
          //     } else if (!snapshot.hasData ||
          //         snapshot.data!.docs.isEmpty) {
          //       commentLength.value = 0;
          //     }

          //     commentLength.value =
          //         snapshot.data!.docs.length;

          //     return Text(
          //       'View all ${commentLength.value} comments',
          //       style: const TextStyle(
          //         color: kGrey,
          //         fontSize: 17,
          //       ),
          //       maxLines: 2,
          //       overflow: TextOverflow.ellipsis,
          //     );
          //   },
          // ),
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
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.isliked,
    required this.likes,
    required this.data, required this.likesNotifier,
  });

  final ValueNotifier<bool> isliked;
    final ValueNotifier<List> likesNotifier;

  final List likes;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isliked,
        builder: (context, value, child) {
          return IconButton(
            onPressed: () async {
                final FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (likes.contains(currentuserdata!.uid)) {
      await firestore.collection('post').doc(data['postId']).update({
        'likes': FieldValue.arrayRemove([currentuserdata!.uid])
      });
      likes.remove(currentuserdata!.uid);
        likesNotifier.value = List.from(likesNotifier.value)..remove(currentuserdata!.uid);
      isliked.value = false;
    } else {
      await firestore.collection('post').doc(data['postId']).update({
        'likes': FieldValue.arrayUnion([currentuserdata!.uid])
      });
      likes.add(currentuserdata!.uid!);
        likesNotifier.value = List.from(likesNotifier.value)..add(currentuserdata!.uid);
      isliked.value = true;
    }
    log('like user : $likes like ${isliked.value}');
    await AuthMethod().updateSavepots(
        uid: currentuserdata!.uid!, postId: data['postId']);
            },
            icon: isliked.value
                ? const Icon(
                    kfavorite,
                    size: 29,
                    color: kRed,
                  )
                : const Icon(
                    kfavorite_outline,
                    size: 29,
                  ),
          );
        });
  }
}

class Savebutton extends StatelessWidget {
  const Savebutton({
    super.key,
    required this.issaved,
    required this.saveby,
    required this.data,
  });

  final ValueNotifier<bool> issaved;
  final List saveby;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: issaved,
        builder: (context, value, child) {
          return IconButton(
            onPressed: () async {
              final FirebaseFirestore firestore = FirebaseFirestore.instance;
              if (saveby.contains(currentuserdata!.uid)) {
                await firestore.collection('post').doc(data['postId']).update({
                  'saveby': FieldValue.arrayRemove([currentuserdata!.uid])
                });
                saveby.remove(currentuserdata!.uid);
                issaved.value = false;
              } else {
                await firestore.collection('post').doc(data['postId']).update({
                  'saveby': FieldValue.arrayUnion([currentuserdata!.uid])
                });
                saveby.add(currentuserdata!.uid!);
                issaved.value = true;
              }
              log('save user : $saveby saved ${issaved.value}');
              await AuthMethod().updateSavepots(
                  uid: currentuserdata!.uid!, postId: data['postId']);
            },
            icon: Icon(
              issaved.value
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
              size: 28,
            ),
          );
        });
  }
}
