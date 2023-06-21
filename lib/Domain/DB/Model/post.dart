import 'package:cloud_firestore/cloud_firestore.dart';

class post {
  final String description;
  final String username;
  final String ProfileImage;
  final String postId;
  final String datePublish;
  String? uid;
  final String? postUrl;
  final likes;
  final String Location;
  final String music;
  post({
    required this.Location,
    required this.music,
    required this.description,
    required this.likes,
    this.uid,
    required this.ProfileImage,
    required this.username,
    required this.postId,
    required this.datePublish,
    required this.postUrl,
  });

  Map<String, dynamic> tojson() => {
        'description': description,
        'username': username,
        'postId': postId,
        'datePublish': datePublish,
        'ProfileImage': ProfileImage,
        'uid': uid,
        'postUrl': postUrl,
        'likes': likes,
        'Location': Location,
        'music': music,
      };

  static post fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data()
        as Map<String, dynamic>; //declare userdata as Map<string , dynamic>
    return post(
      music: snap['music'],
      Location: snap['Location'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublish: snapshot['datePublish'],
      username: snapshot['username'],
      postUrl: snapshot['postUrl'],
      ProfileImage: snapshot['ProfileImage'],
      likes: snapshot['likes'],
      uid: snapshot['uid'],
    );
  }
}
