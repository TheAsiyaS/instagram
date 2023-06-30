import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Presenation/Home/Comment.dart';
import 'package:instagram_clone/utenslis/variables.dart';

// ignore: must_be_immutable
class Iconbuttons extends StatelessWidget {
  Iconbuttons({
    super.key,
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
  });

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
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (iconId == "fav_out_in_post") {
          if (postid!.isNotEmpty) {
            print('object');
            FirestoreMethods().postLike(currentuserdata.uid!, postid!, likes!);
          } else {
            print('empty');
          }
        } else if (iconId == 'cmt_out_in_post') {
          print('-------------${postid}-------------');
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
        } else if (iconId == 'username_edite_profile') {}
      },
      icon: icon,
      style: style,
    );
  }
}
