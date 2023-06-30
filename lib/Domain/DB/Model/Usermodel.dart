import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String phoneNumber;
  final String username;
  String? photoUrl;
  final String email;
  final String password;
  String? uid;
  final List<dynamic> follower;
  final List<dynamic> following;
  final String bio;
  final bool isStory;
  final bool highlight;
  String? name;

  UserData({
    required this.phoneNumber,
    this.uid,
    required this.isStory,
    this.photoUrl,
    required this.username,
    required this.email,
    required this.password,
    required this.bio,
    required this.follower,
    required this.following,
    required this.highlight,
    this.name,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'username': username,
        'email': email,
        'password': password,
        'photoUrl': photoUrl,
        'uid': uid,
        'follower': follower,
        'following': following,
        'bio': bio,
        'isStory': isStory,
        'highlight': highlight,
        'name': name,
      };

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      phoneNumber: snapshot['phoneNumber'],
      username: snapshot['username'],
      email: snapshot['email'],
      password: snapshot['password'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      follower: List<dynamic>.from(snapshot['follower']),
      following: List<dynamic>.from(snapshot['following']),
      bio: snapshot['bio'],
      isStory: snapshot['isStory'],
      highlight: snapshot['highlight'],
      name: snapshot['name'],
    );
  }
}
