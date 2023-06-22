import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String PhoneNumber;
  final String username;
  String? photoUrl;
  final String email;
  final String password;
  String? uid;
  final List follower;
  final List following;
  final String bio;
  final bool IsStory;
  final bool highLight;
  String? name;
  UserData(
      {required this.PhoneNumber,
      this.uid,
      required this.IsStory,
      this.photoUrl,
      required this.username,
      required this.email,
      required this.password,
      required this.bio,
      required this.follower,
      required this.following,
      required this.highLight,
      this.name});

  Map<String, dynamic> tojson() => {
        'PhoneNumber': PhoneNumber,
        'username': username,
        'email': email,
        'password': password,
        'photoUrl': photoUrl,
        'uid': uid,
        'follower': follower,
        'following': following,
        'bio': bio,
        'IsStory': IsStory,
        'highLight': highLight,
        'name': name,
      };

  static UserData fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data()
        as Map<String, dynamic>; //declare userdata as Map<string , dynamic>
    return UserData(
      highLight: snapshot['highLight'],
      IsStory: snapshot['IsStory'],
      PhoneNumber: snapshot['PhoneNumber'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      password: snapshot['password'],
      username: snapshot['username'],
      follower: snapshot['follower'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}
