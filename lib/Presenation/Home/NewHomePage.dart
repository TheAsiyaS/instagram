import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:instagram_clone/Presenation/Home/post.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
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

                      String? datePublish = data['datePublished'];
                      if (datePublish != null) {
                        DateTime myDate = DateTime.parse(datePublish);
                        formattedDate.value =
                            DateFormat('dd-MM-yyyy').format(myDate);
                        final finaldate = formattedDate.value.split(' ');

                        return post(
                            size: size,
                            data: data,
                            likes: likes,
                            date: formattedDate.value,
                            saveby: saveby,
                            finaldate: finaldate);
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
