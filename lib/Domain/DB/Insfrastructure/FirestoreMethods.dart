import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Domain/DB/Model/Search_model.dart';
import 'package:instagram_clone/domain/db/model/comment.dart';
import 'package:instagram_clone/domain/db/model/post.dart';
import 'package:instagram_clone/main.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadPost({
    required String description,
    required String imagePath,
    required String username,
    required String profileUrl,
    required String uid,
    required String location,
    required String music,
    required String filterColor,
    required List<dynamic> tag,
  }) async {
    bool isOk = false;

    try {
      final String postId = const Uuid().v1();
      final PostModel post = PostModel(
          location: location,
          music: music,
          likes: [],
          description: description,
          username: username,
          postId: postId,
          datePublished: DateTime.now().toString(),
          postUrl: imagePath,
          uid: uid,
          profileImage: profileUrl,
          filterColor: filterColor,
          tag: tag);

      final jsonData = post.toJson();
      await _firestore.collection('post').doc(postId).set(jsonData);
      await AuthMethod().updatepots(postuid: postId, uid: currentuserdata.uid);
      isOk = true;
    } catch (e, stackTrace) {
      isOk = false;
      log('Error: $e\nStackTrace: $stackTrace');
    }

    return isOk;
  }

  Future<bool> postLike(String uid, String postId, List<dynamic> likes) async {
    bool isOk = false;

    try {
      if (likes.contains(uid)) {
        _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        isOk = false;
      } else {
        _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        isOk = true;
      }
    } catch (e) {
      isOk = false;
    }

    return isOk;
  }

  Future<bool> uploadComment({
    required String comment,
    required String username,
    required String profileImage,
    required String postId,
    required String uid,
    required String datePublished,
  }) async {
    bool isOk = false;

    try {
      if (comment.isNotEmpty) {
        final commentId = const Uuid().v1();
        final Comment commentModel = Comment(
          comment: comment,
          profileImage: profileImage,
          username: username,
          postId: postId,
          datePublished: datePublished,
          uid: uid,
          commentId: commentId,
          likes: 1,
        );

        final jsonData = commentModel.toJson();
        await _firestore
            .collection('post')
            .doc(postId)
            .collection('comment')
            .doc(commentId)
            .set(jsonData);
        isOk = true;
      } else {
        log('Some error occurred');
        isOk = false;
      }
    } catch (e) {
      isOk = false;
    }

    return isOk;
  }

  Future<bool> deletePost(String postId) async {
    try {
      await _firestore.collection('post').doc(postId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> followUser(String currentUserId, String followedUserId) async {
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('user').doc(currentUserId).get();
    final List<dynamic> following = snap.data()!['following'];

    if (following.contains(followedUserId)) {
      await _firestore.collection('user').doc(currentUserId).update({
        'following': FieldValue.arrayRemove([followedUserId])
      });
      await _firestore.collection('user').doc(followedUserId).update({
        'follower': FieldValue.arrayRemove([currentUserId])
      });
    } else {
      await _firestore.collection('user').doc(currentUserId).update({
        'following': FieldValue.arrayUnion([followedUserId])
      });
      await _firestore.collection('user').doc(followedUserId).update({
        'follower': FieldValue.arrayUnion([currentUserId])
      });
    }
  }

  Future<bool> search_add(
      {required String profileImg,
      required String username,
      required String serach_query,
      required String useruid}) async {
    bool isOk;
    try {
      if (serach_query.isNotEmpty) {
        final searchUid = const Uuid().v1();
        final SearchModel searchModel = SearchModel(
            profileImg: profileImg,
            username: username,
            serach_query: serach_query,
            useruid: useruid,
            searchUid: searchUid);

        final jsonData = searchModel.toJson();
        await _firestore.collection('search').doc(searchUid).set(jsonData);
        isOk = true;
      }

      isOk = true;
    } catch (e) {
      isOk = false;
    }
    return isOk;
  }

  Future<bool> deleteSearch({required uid}) async {
    bool isok;
    try {
      if (uid != null) {
        await _firestore.collection('search').doc(uid).delete();
        isok = true;
      }
      isok = true;
    } catch (e) {
      isok = false;
    }
    return isok;
  }
}
