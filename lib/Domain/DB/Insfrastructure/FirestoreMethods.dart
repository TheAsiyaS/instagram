import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/StorageMethods.dart';
import 'package:instagram_clone/Domain/DB/Model/post.dart';
import 'package:uuid/uuid.dart';

class firestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //func for post Upload to db
  Future<bool> uploadPost(
      {required String description,
      required Uint8List file,
      required String username,
      required profileUrl,
      required String uid,
      required String location,
      required String music}) async {
    late bool isok;
    try {
      //upload image to firebase storage
      final String postURl =
          await storageMethords().uploadImageToStorage('Posts', file, true);
      final String postId = const Uuid().v1();
      //create a post
      post Post = post(
        Location: location,
        music: music,
        likes: [],
        description: description,
        username: username,
        postId: postId,
        datePublish: DateTime.now().toString(),
        postUrl: postURl,
        uid: uid,
        ProfileImage: profileUrl,
      );
      final jsondecode = Post.tojson();
      await _firestore.collection('post').doc(postId).set(jsondecode);
      return isok = true;
    } catch (e) {
      isok = false;
      log(e.toString());
    }
    return isok;
  }
}
