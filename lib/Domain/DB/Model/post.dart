import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String username;
  final String profileImage;
  final String postId;
  final String datePublished;
  final String? uid;
  final String? postUrl;
  final dynamic likes;
  final String location;
  final String music;
  final List<int> filterColor;
  final List<dynamic> tag;
  PostModel({
    required this.location,
    required this.music,
    required this.description,
    required this.likes,
    this.uid,
    required this.profileImage,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.filterColor,
    required this.tag,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'profileImage': profileImage,
        'uid': uid,
        'postUrl': postUrl,
        'likes': likes,
        'location': location,
        'music': music,
        'filterColor': filterColor,
        'tag': tag
      };

  static PostModel fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final snapshot = snap.data();
    return PostModel(
      music: snapshot!['music'],
      location: snapshot['location'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      username: snapshot['username'],
      postUrl: snapshot['postUrl'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
      uid: snapshot['uid'],
      filterColor: snapshot['filterColor'],
      tag: snapshot['tag'],
    );
  }
}


