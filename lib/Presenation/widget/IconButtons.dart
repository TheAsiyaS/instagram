import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Presenation/Account/Account_screen.dart';
import 'package:instagram_clone/Presenation/Account/Others_account.dart';
import 'package:instagram_clone/Presenation/Home/Comment.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

// ignore: must_be_immutable
class Iconbuttons extends StatelessWidget {
  Iconbuttons(
      {super.key,
      required this.icon,
      required this.iconId,
      required this.style,
      this.likes,
      this.postid,
      this.date,
      this.description,
      this.profileimg,
      this.uid,
      this.username,
      this.taguid});

  final Widget icon;
  final String iconId;
  final ButtonStyle style;
  String? postid;
  String? profileimg;
  String? username;
  String? date;
  String? description;
  String? uid;
  List<dynamic>? likes;
  List<dynamic>? taguid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IconButton(
      onPressed: () async {
        if (iconId == "fav_out_in_post") {
          if (postid!.isNotEmpty) {
            FirestoreMethods().postLike(currentuserdata.uid!, postid!, likes!);
          } else {}
        } else if (iconId == 'cmt_out_in_post') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => commentScreen(
                    ProfileUrl: profileimg,
                    Username: username,
                    date: date,
                    description: description,
                    uid: uid,
                    postId: postid,
                  )));
        } else if (iconId == 'check_in_edite') {
          await AuthMethod()
              .updateName(name: name.value, uid: currentuserdata.uid);
          await AuthMethod().updateUsername(
              username: editeusername.value, uid: currentuserdata.uid);
          newusername.value = editeusername.value;
          newname.value = name.value;
          newbio.value = bio.value;
          await AuthMethod()
              .updateBio(bio: bio.value, uid: currentuserdata.uid);

          Navigator.of(context).pop();
        } else if (iconId == 'tag_persons') {
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
              return SizedBox(
                width: size.width,
                height: size.height / 3,
                child: taguid!.isEmpty
                    ? const Center(child: Text('No tagged users in this post'))
                    : FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('user')
                            .where(
                              'uid',
                              whereIn: taguid,
                            )
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Some Error Occurred!'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text('No tagged users in this post'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: kWhite,
                              ),
                            );
                          } else {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                final data = snapshot.data!.docs[index];

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
                              itemCount: snapshot.data!.docs.length,
                            );
                          }
                        },
                      ),
              );
            },
          );
        } else if (iconId == 'save_out_in_post') {}
      },
      icon: icon,
      style: style,
    );
  }
}
