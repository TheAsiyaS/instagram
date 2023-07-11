import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String comment;
  final String username;
  final String profileImage;
  String? commentId;
  final String? uid;
  final List<dynamic> likes;
  final String postId;
  final String datePublished;

  Comment({
    required this.comment,
    required this.likes,
    this.uid,
    required this.profileImage,
    required this.username,
    required this.postId,
    required this.datePublished,
    this.commentId,
  });

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'username': username,
        'postId': postId,
        'commentId': commentId,
        'profileImage': profileImage,
        'uid': uid,
        'likes': likes,
        'datePublished': datePublished,
      };

  static Comment fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    return Comment(
      comment: snapshot!['comment'],
      postId: snapshot['postId'],
      commentId: snapshot['commentId'],
      username: snapshot['username'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
    );
  }
}
