import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String comment;
  final String username;
  final String ProfileImage;
  final String CommentId;
  String? uid;
  String DatePublished;
  final likes;
  final String postId;
  Comment({
    required this.comment,
    required this.likes,
    this.uid,
    required this.ProfileImage,
    required this.username,
    required this.postId,
    required this.DatePublished,
    required this.CommentId,
  });

  Map<String, dynamic> tojson() => {
        'comment': comment,
        'username': username,
        'postId': postId,
        'CommentId': CommentId,
        'ProfileImage': ProfileImage,
        'uid': uid,
        'likes': likes,
        'datePublished': DatePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data()
        as Map<String, dynamic>; //declare userdata as Map<string , dynamic>
    return Comment(
      comment: snapshot['comment'],
      postId: snapshot['postId'],
      CommentId: snapshot['CommentId'],
      username: snapshot['username'],
      ProfileImage: snapshot['ProfileImage'],
      likes: snapshot['likes'],
      uid: snapshot['uid'],
      DatePublished: snapshot['datePublished'],
    );
  }
}
