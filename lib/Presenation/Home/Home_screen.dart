import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
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
    final ValueNotifier<bool> _direction = ValueNotifier(true);
    final ValueNotifier<int> itemCount = ValueNotifier(1);
    final ValueNotifier<List> likes = ValueNotifier([]);
    final ValueNotifier<int> commentLength = ValueNotifier(0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      currentuserdata = await AuthMethod().getUserDetail();
      print(
          '----------------${currentuserdata.bio}----------------------------------');
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _direction,
        builder: (context, newDirection, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.forward) {
                _direction.value = true;
              } else if (direction == ScrollDirection.reverse) {
                _direction.value = false;
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
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: size.height / 6,
                          child: GridView.count(
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              10,
                              (index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final data =
                                          await AuthMethod().getUserDetail();
                                      print('-----------${data.bio}');
                                    },
                                    child: const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://i0.wp.com/blog.apilayer.com/wp-content/uploads/2022/11/pexels-photo-574073.jpeg?resize=1132%2C694&ssl=1'),
                                    ),
                                  ),
                                  const Text('Username')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList.separated(
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('post')
                                  .snapshots(),
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
                                } else if (snapshot.hasData) {
                                  final data = snapshot.data!.docs[index];
                                  ValueNotifier<String> formattedDate =
                                      ValueNotifier(data['datePublish']);
                                  likes.value = data['likes'];
                                  itemCount.value = snapshot.data!.docs.length;
                                  String? datePublish = data['datePublish'];

                                  if (datePublish != null) {
                                    DateTime myDate =
                                        DateTime.parse(datePublish);
                                    formattedDate.value =
                                        DateFormat('dd-MM-yyyy').format(myDate);
                                  } else {}
                                  final finaldate =
                                      formattedDate.value.split(' ');
                                  String colorString = data['filtercolor'];
                                  String extractedCode = colorString.substring(
                                      6, colorString.length - 1);
                                  final parscode = int.parse(extractedCode);
                                  print(data['ProfileImage']);
                                  return SizedBox(
                                    height: size.height / 1.39,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
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
                                            color: Color(parscode),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Iconbuttons(
                                              icon: likes.value.contains(
                                                      currentuserdata.uid)
                                                  ? const Icon(
                                                      kfavorite,
                                                      size: 29,
                                                      color: kRed,
                                                    )
                                                  : const Icon(
                                                      kfavorite_outline,
                                                      size: 29,
                                                    ),
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
                                              profileimg: data['ProfileImage'],
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
                                            Iconbuttons(
                                              icon: const Icon(
                                                ksave,
                                                size: 28,
                                              ),
                                              iconId: 'save_out_in_post',
                                              style: IconButton.styleFrom(),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          ' ${likes.value.length} likes',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
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
                          return const Divider();
                        },
                        itemCount: itemCount.value,
                      ),
                    ],
                  ),
                  _direction.value
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
