import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/Account_screen.dart';
import 'package:instagram_clone/Presenation/Account/Post_page.dart';
import 'package:instagram_clone/Presenation/Account/Tag_page.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';


class OthersProfile extends StatelessWidget {
  const OthersProfile({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('user').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kWhite,
                  strokeWidth: 2,
                ),
              );
            } else if (!snapshot.hasData || snapshot.hasError) {
              return const Text('No user found!!!');
            } else {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              ValueNotifier<List> follower =
                  ValueNotifier(userData['follower']);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              follower.notifyListeners();
              ValueNotifier<List> following =
                  ValueNotifier(userData['following']);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              follower.notifyListeners();

              return Scaffold(
                appBar: AppBar( 
                 
                  title: Text(
                    userData['username'],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      userData['photoUrl'],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('post')
                                              .where('uid', isEqualTo: uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Text('0');
                                            } else {
                                              return Text(
                                                  "${snapshot.data!.docs.length}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold));
                                            }
                                          }),
                                      sizedBoxHeight10,
                                      const Text('Posts'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        follower.value.length.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      sizedBoxHeight10,
                                      const Text('Followers'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(following.value.length.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      sizedBoxHeight10,
                                      const Text('Following'),
                                    ],
                                  ),
                                ],
                              ),
                              sizedBoxHeight10,
                              Text(
                                userData['name'],
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
                                        userData['bio'],
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
                              child: Elevated_button(
                                  elevatedbutttonwidget: Text(follower.value
                                          .contains(currentuserdata.uid)
                                      ? 'Following'
                                      : 'Follow'),
                                  elevatedbutttonid: 'follow_inaccount',
                                  uid: uid,
                                  elevatedbuttonstyle: ElevatedButton.styleFrom(
                                      backgroundColor: kBlue)),
                            ),
                            SizedBox(
                              width: size.width / 2.6,
                              child: Elevated_button(
                                  elevatedbutttonwidget: const Text('Message'),
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
                              Postpage(uid: uid),
                               Tagpage(uid:uid ,)
                            ]))
                      ],
                    ),
                  ),
                )),
              );
            }
          }),
    );
  }
}
