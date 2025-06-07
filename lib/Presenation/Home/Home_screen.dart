
import 'dart:developer';
import 'dart:math' hide log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ValueNotifier<bool> direction0 = ValueNotifier(true);
    final ValueNotifier<int> itemCount = ValueNotifier(1);
    final ValueNotifier<List> likes = ValueNotifier([]);
    final ValueNotifier<int> commentLength = ValueNotifier(0);
    final ValueNotifier<List> savepost =
        ValueNotifier(currentuserdata!.savePosts);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      savepost.value = currentuserdata!.savePosts;
    });

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: direction0,
        builder: (context, newDirection, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.forward) {
                direction0.value = true;
              } else if (direction == ScrollDirection.reverse) {
                direction0.value = false;
              }
              return true;
            },
            child: SafeArea(
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: size.height / 13,
                        ),
                      ),
                      SliverList.separated(
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('post')
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: kWhite,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('Some Error occurred'));
                                }  else if (snapshot.hasData) {
                                  final data = snapshot.data!.docs[index];
                                  ValueNotifier<String> formattedDate =
                                      ValueNotifier(data['datePublished']);
                                  likes.value = data['likes'];
                                  savepost.value = currentuserdata!.savePosts;
                                  itemCount.value = snapshot.data!.docs.length;
                                  String? datePublish = data['datePublished'];
                                  if (datePublish != null) {
                                    DateTime myDate =
                                        DateTime.parse(datePublish);
                                    formattedDate.value =
                                        DateFormat('dd-MM-yyyy').format(myDate);
                                  } else {}
                                  final finaldate =
                                      formattedDate.value.split(' ');
                                  // List<int> colorString =
                                 log("filter color : ${data['filterColor']}");
                                 
                                  final ValueNotifier<bool> issave =
                                      ValueNotifier(currentuserdata!.savePosts
                                          .contains(data['postId']));
                                  return SizedBox(
                                    height: size.height / 1.24,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                backgroundImage: NetworkImage(
                                                    data['profileImage']),
                                              ),
                                              sizedBoxWidth10,
                                              Text(
                                                data['username'],
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Spacer(),
                                              PopupMenuButton<String>(
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return <PopupMenuEntry<
                                                      String>>[
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
                                                onSelected:
                                                    (String value) async {
                                                  if (value == '1') {
                                                    if (data['uid'] ==
                                                        currentuserdata!.uid) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      EditingPost(
                                                                        postdata: snapshot
                                                                            .data!
                                                                            .docs[index],
                                                                      )));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              backgroundColor:
                                                                  kRed,
                                                              content: SnackbarWidget(
                                                                  icon: kremove,
                                                                  message:
                                                                      'You can\'t edit this post only user can edit ')));
                                                    }
                                                  } else if (value == '2') {
                                                    if (data['uid'] ==
                                                        currentuserdata!.uid) {
                                                      await FirestoreMethods()
                                                          .deletePost(
                                                              data['postId']);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              backgroundColor:
                                                                  kRed,
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
                                            color:  Color.fromARGB(data['filterColor'][0], data['filterColor'][1], data['filterColor'][2], data['filterColor'][3]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Iconbuttons(
                                                    icon: const Icon(
                                                      kaccountcircle,
                                                      color: kBlack,
                                                      size: 32,
                                                    ),
                                                    taguid: data['tag'],
                                                    iconId: 'tag_persons',
                                                    style:
                                                        IconButton.styleFrom()),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Iconbuttons(
                                              icon: likes.value.contains(
                                                      currentuserdata!.uid)
                                                  ? const Icon(
                                                      kfavorite,
                                                      size: 29,
                                                      color: kRed,
                                                    )
                                                  : const Icon(
                                                      kfavorite_outline,
                                                      size: 29,
                                                    ),
                                              postid: data['postId'],
                                              likes: likes.value,
                                              iconId: 'fav_out_in_post',
                                              style: IconButton.styleFrom(),
                                            ),
                                            Iconbuttons(
                                              icon: const Icon(
                                                kcomment,
                                                size: 28,
                                              ),
                                              iconId: 'cmt_out_in_post',
                                              likes: likes.value,
                                              postid: data['postId'],
                                              date: formattedDate.value,
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
                                            ValueListenableBuilder(
                                                valueListenable: issave,
                                                builder: (context, value, _) {
                                                  return IconButton(
                                                    onPressed: () async {
                                                      if (currentuserdata!
                                                          .savePosts
                                                          .contains(
                                                              data['postId'])) {
                                                        savepost.value.remove(
                                                            data['postId']);
                                                        issave.value = false;
                                                        savepost
                                                            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                                            .notifyListeners();
                                                      } else {
                                                        issave.value = true;
                                                        savepost.value.add(
                                                            data['postId']);
                                                        savepost
                                                            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                                            .notifyListeners();
                                                      }

                                                      await AuthMethod()
                                                          .updateSavepots(
                                                              postId: data[
                                                                  'postId']!,
                                                              uid:
                                                                  currentuserdata!
                                                                      .uid!);
                                                    },
                                                    icon: Icon(
                                                      issave.value
                                                          ? ksaved
                                                          : ksave,
                                                      size: 28,
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40),
                                                  topRight: Radius.circular(40),
                                                ),
                                              ),
                                              backgroundColor: kTransparentGrey,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  width: size.width,
                                                  height: size.height / 3,
                                                  child: likes.value.isEmpty
                                                      ? const Center(
                                                          child: Text(
                                                              'No Likes for this post'))
                                                      : FutureBuilder<
                                                          QuerySnapshot>(
                                                          future:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'user')
                                                                  .where(
                                                                    'uid',
                                                                    whereIn: likes
                                                                        .value,
                                                                  )
                                                                  .get(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              return const Center(
                                                                  child: Text(
                                                                      'Some Error Occurred!'));
                                                            } else if (!snapshot
                                                                    .hasData ||
                                                                snapshot
                                                                    .data!
                                                                    .docs
                                                                    .isEmpty) {
                                                              return const Center(
                                                                  child: Text(
                                                                      'No Likes for this post'));
                                                            } else if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  color: kWhite,
                                                                ),
                                                              );
                                                            } else {
                                                              return ListView
                                                                  .separated(
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final data =
                                                                      snapshot
                                                                          .data!
                                                                          .docs[index];

                                                                  return ListTile(
                                                                    leading:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          30,
                                                                      backgroundImage:
                                                                          NetworkImage(
                                                                              data['photoUrl']),
                                                                    ),
                                                                    title: Text(
                                                                        data[
                                                                            'username']),
                                                                    subtitle:
                                                                        Text(data[
                                                                            'name']),
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => OthersProfile(uid: data['uid'])));
                                                                    },
                                                                  );
                                                                },
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return const Divider(
                                                                    color:
                                                                        kWhite,
                                                                  );
                                                                },
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                              );
                                                            }
                                                          },
                                                        ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            ' ${likes.value.length} likes',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
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
                                        StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                          stream: FirebaseFirestore.instance
                                              .collection('post')
                                              .doc(data['postId'])
                                              .collection('comment')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: kWhite,
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child:
                                                    Text('Some Error occurred'),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              commentLength.value = 0;
                                            }

                                            commentLength.value =
                                                snapshot.data!.docs.length;

                                            return Text(
                                              'View all ${commentLength.value} comments',
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
                                } else {
                                  return const Text('Data Currently not found');
                                }
                              });
                        },
                        separatorBuilder: (context, index) {
                          return sizedBoxHeight10;
                        },
                        itemCount: itemCount.value,
                      ),
                    ],
                  ),
                  direction0.value
                      ? AnimatedContainer(
                          duration: const Duration(microseconds: 500),
                          color: kBlack,
                          child: Row(
                            children: [
                              Text(
                                'Instagram',
                                style: GoogleFonts.grandHotel(
                                  fontSize: 45,
                                ),
                              ),
                              const Spacer(),
                              Iconbuttons(
                                icon: const Icon(
                                  kfavorite_outline,
                                  size: 29,
                                ),
                                iconId: 'fav_out_home_appbar',
                                style: IconButton.styleFrom(),
                              ),
                              Iconbuttons(
                                icon: const Icon(
                                  kmessage,
                                  size: 28,
                                ),
                                iconId: 'msg_out_home_appbar',
                                style: IconButton.styleFrom(),
                              ),
                            ],
                          ),
                        )
                      : sizedBoxHeight10,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
