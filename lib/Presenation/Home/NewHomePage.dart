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

class Newhomepage extends StatefulWidget {
  const Newhomepage({super.key});

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage> {
  bool direction0 = true;
  bool loading = true;
  QuerySnapshot<Map<String, dynamic>>? postdata;
  QuerySnapshot<Map<String, dynamic>>? likeData;
  List likes = [];
  
    //bool issaved;
  @override
  void initState() {
    super.initState();
    fetchPostData(); // call async function without await
  }

  Future<void> fetchPostData() async {
    postdata = await FirebaseFirestore.instance.collection('post').get();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      List saveby = [];
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          if (direction == ScrollDirection.forward) {
            direction0 = true;
          } else if (direction == ScrollDirection.reverse) {
            direction0 = false;
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
                    if (loading == true) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final data = postdata!.docs[index];

                      ValueNotifier<String> formattedDate =
                          ValueNotifier(data['datePublished']);

                      likes = data['likes'];
                      saveby = data['saveby'];
//issaved = saveby.contains(currentuserdata.uid)
                      String? datePublish = data['datePublished'];
                      if (datePublish != null) {
                        DateTime myDate = DateTime.parse(datePublish);
                        formattedDate.value =
                            DateFormat('dd-MM-yyyy').format(myDate);

                        final finaldate = formattedDate.value.split(' ');

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
                                      backgroundImage:
                                          NetworkImage(data['profileImage']),
                                    ),
                                    sizedBoxWidth10,
                                    Text(
                                      data['username'],
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
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
                                          if (data['uid'] ==
                                              currentuserdata!.uid) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditingPost(
                                                          postdata: postdata!
                                                              .docs[index],
                                                        )));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: kRed,
                                                    content: SnackbarWidget(
                                                        icon: kremove,
                                                        message:
                                                            'You can\'t edit this post only user can edit ')));
                                          }
                                        } else if (value == '2') {
                                          if (data['uid'] ==
                                              currentuserdata!.uid) {
                                            await FirestoreMethods()
                                                .deletePost(data['postId']);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
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
                                          style: IconButton.styleFrom()),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Iconbuttons(
                                    icon: likes.contains(currentuserdata!.uid)
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
                                    likes: likes,
                                    iconId: 'fav_out_in_post',
                                    style: IconButton.styleFrom(),
                                  ),
                                  Iconbuttons(
                                    icon: const Icon(
                                      kcomment,
                                      size: 28,
                                    ),
                                    iconId: 'cmt_out_in_post',
                                    likes: likes,
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
                                  IconButton(
                                    onPressed: () async {
                                         log('save user : ${saveby}');
                                      final FirebaseFirestore _firestore =
                                          FirebaseFirestore.instance;
                                      if (saveby
                                          .contains(currentuserdata!.uid)) {
                                        await _firestore
                                            .collection('post')
                                            .doc(data['postId'])
                                            .update({
                                          'saveby': FieldValue.arrayRemove(
                                              [currentuserdata!.uid])
                                        });
                                        setState(() {
                                          saveby.remove(currentuserdata!.uid);
                                        });
                                      } else {
                                        await _firestore
                                            .collection('post')
                                            .doc(data['postId'])
                                            .update({
                                          'saveby': FieldValue.arrayUnion(
                                              [currentuserdata!.uid])
                                        });
                                        setState(() {
                                          saveby.add(currentuserdata!.uid!);
                                        });
                                      }
                                      log('save user : ${saveby}');
                                      // await AuthMethod().updateSavepots(
                                      //     uid: currentuserdata!.uid!,
                                      //     postId: data['postId']);
                                    },
                                    icon: Icon(
                                      saveby.contains(currentuserdata!.uid)
                                          ? ksaved
                                          : ksave,
                                      size: 28,
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (likes.isEmpty) {
                                    return;
                                  }
                                  likeData = await FirebaseFirestore.instance
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
                                      context: context,
                                      builder: (BuildContext context) {
                                        return likeData!.docs.isEmpty
                                            ? Text('This post have no likes')
                                            : SizedBox(
                                                width: size.width,
                                                height: size.height / 3,
                                                child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) {
                                                    final data =
                                                        likeData!.docs[index];

                                                    return ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(data[
                                                                'photoUrl']),
                                                      ),
                                                      title: Text(
                                                          data['username']),
                                                      subtitle:
                                                          Text(data['name']),
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OthersProfile(
                                                                        uid: data[
                                                                            'uid'])));
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Divider(
                                                      color: kWhite,
                                                    );
                                                  },
                                                  itemCount:
                                                      likeData!.docs.length,
                                                ));
                                      });
                                },
                                child: Text(
                                  ' ${likes.length} likes',
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
                      } else {
                        return const Text('Data Currently not found');
                      }
                    }
                  },
                  separatorBuilder: (context, index) {
                    return sizedBoxHeight10;
                  },
                  itemCount: postdata!.docs.length,
                )
              ],
            ),
            direction0
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
        )),
      ),
    );
  }
}
