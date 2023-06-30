import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String phoneNumber;
  final String username;
  final String photoUrl;
  final String email;
  final String password;
  String? uid;
  final List<dynamic> follower;
  final List<dynamic> following;
  final String bio;
  final String dateJoin;
  final int changeUsername;
  final String name;
  final List<dynamic> posts;
  String? acLocation;
   final List<dynamic> savePosts;
  UserData(
      {required this.phoneNumber,
      this.uid,
      required this.dateJoin,
     required this.photoUrl,
      required this.username,
      required this.email,
      required this.password,
      required this.bio,
      required this.follower,
      required this.following,
      required this.changeUsername,
      required this.posts,
    required this.savePosts,
     required this.name,
      this.acLocation});

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
        'dateJoin': dateJoin,
        'changeUsername': changeUsername,
        'name': name,
        'posts': posts,
        'acLocation': acLocation,
        'savePosts':savePosts
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
        dateJoin: snapshot['dateJoin'],
        changeUsername: snapshot['changeUsername'],
        name: snapshot['name'],
        posts: List<dynamic>.from(snapshot['posts']),
        acLocation: snapshot['acLocation'],
        savePosts:List<dynamic>.from(snapshot['savePosts']),
        );
  }
}
