import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Presenation/Account/Account_screen.dart';
import 'package:instagram_clone/Presenation/Account/Post_page.dart';
import 'package:instagram_clone/Presenation/Account/Tag_page.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class OthersProfile extends StatefulWidget {
  const OthersProfile({super.key, required this.uid});
  final String uid;

  @override
  State<OthersProfile> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  QuerySnapshot<Map<String, dynamic>>? postdata;
  Map<String, dynamic>? userData;
  List followers = [];
  List following = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchPostData(); // call async function without await
  }

  Future<void> fetchPostData() async {
    DocumentSnapshot<Map<String, dynamic>> Data = await FirebaseFirestore
        .instance
        .collection('user')
        .doc(widget.uid)
        .get();

    userData = Data.data();
    followers = userData!['follower'];
    following = userData!['following'];
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ValueNotifier<bool> isfollow =
        ValueNotifier(followers.contains(widget.uid));
    return DefaultTabController(
        length: 2,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    userData!['username'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                ),
                body: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height / 3.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBoxHeight10,
                              Profiletop(
                                userData: userData,
                                widget: widget,
                                Followers: followers,
                                Following: following,
                              ),
                              sizedBoxHeight10,
                              Text(
                                userData!['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              sizedBoxHeight5,
                              SizedBox(
                                height: size.height / 12,
                                width: size.width / 1.4,
                                child: ValueListenableBuilder(
                                    valueListenable: newbio,
                                    builder: (context, snapshot, _) {
                                      return Text(
                                        userData!['bio'],
                                        maxLines: 3,
                                        style: const TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: size.width / 2.6,
                              child: ValueListenableBuilder(
                                  valueListenable: isfollow,
                                  builder: (context, value, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          await FirestoreMethods().followUser(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              widget.uid);
                                          if (followers.contains(widget.uid)) {
                                            setState(() {
                                              followers.remove(widget.uid);
                                            });

                                            isfollow.value = false;
                                          } else {
                                            setState(() {
                                              followers.add(widget.uid);
                                            });

                                            isfollow.value = true;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: kBlue),
                                        child: Text(
                                          isfollow.value
                                              ? 'Following'
                                              : 'Follow',
                                          style: TextStyle(color: kWhite),
                                        ));
                                  }),
                            ),
                            SizedBox(
                              width: size.width / 2.6,
                              child: Elevated_button(
                                  elevatedbutttonwidget: const Text(
                                    'Message',
                                    style: TextStyle(color: kWhite),
                                  ),
                                  elevatedbutttonid: 'message_inaccount',
                                  elevatedbuttonstyle: ElevatedButton.styleFrom(
                                      backgroundColor: kGreyDarkTrans)),
                            ),
                          ],
                        ),
                        sizedBoxHeight10,
                        const Text(
                          'Story Highlights',
                          style: TextStyle(fontSize: 17),
                        ),
                        sizedBoxHeight10,
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: kWhite, width: 1.5),
                                  ),
                                  child: const Icon(
                                    kadd,
                                    size: 35,
                                  ),
                                ),
                                sizedBoxHeight10,
                                const Text('New')
                              ],
                            ),
                            SizedBox(
                              width: size.width / 1.3,
                              height: size.height / 7,
                              child: GridView.count(
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 1,
                                children: List.generate(
                                  1,
                                  (index) => Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
                                      ),
                                      sizedBoxHeight10,
                                      Text('New$index')
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        TabBar(
                          isScrollable: true,
                          labelColor: kWhite,
                          unselectedLabelColor: kGrey,
                          indicatorColor: kGrey,
                          indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          tabs: [
                            Tab(
                              child: SizedBox(
                                  height: 50,
                                  width: size.width / 3,
                                  // color: kred,
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Icon(kgrid))),
                            ),
                            Tab(
                              child: SizedBox(
                                  height: 50,
                                  width: size.width / 3,
                                  // color: kred,
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Icon(kTagperson))),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: size.height / 1.5,
                            child: TabBarView(children: [
                              Postpage(uid: widget.uid),
                              Tagpage(
                                uid: widget.uid,
                              )
                            ]))
                      ],
                    ),
                  ),
                )),
              ));
  }
}

class Profiletop extends StatelessWidget {
  const Profiletop({
    super.key,
    required this.userData,
    required this.widget,
    required this.Followers,
    required this.Following,
  });

  final Map<String, dynamic>? userData;
  final OthersProfile widget;
  final List Followers;
  final List Following;
  @override
  Widget build(BuildContext context) {
    List postIds = userData!['posts'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            userData!['photoUrl'],
          ),
        ),
        Column(
          children: [
            Text("${postIds.length}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            sizedBoxHeight10,
            const Text('Posts'),
          ],
        ),
        Column(
          children: [
            Text(
              Followers.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            sizedBoxHeight10,
            const Text('Followers'),
          ],
        ),
        Column(
          children: [
            Text(Following.length.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            sizedBoxHeight10,
            const Text('Following'),
          ],
        ),
      ],
    );
  }
}
