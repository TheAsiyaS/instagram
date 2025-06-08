import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/StorageMethods.dart';
import 'package:instagram_clone/Domain/DB/Model/Usermodel.dart';
import 'package:instagram_clone/Presenation/Account/Account_screen.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/variables.dart';

String? gUid;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserData> getUserDetail() async {
    User? currentUser = _auth.currentUser;

    DocumentSnapshot snapshot =
        await _firestore.collection('user').doc(currentUser!.uid).get();

    if (snapshot.exists) {
      return UserData.fromSnap(snapshot);
    } else {
      throw Exception("User document does not exist");
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
    required String bio,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      gUid = credential.user!.uid;
      final docUser = _firestore.collection('user').doc(credential.user!.uid);
      final data = UserData(
        changeUsername: 0,
        phoneNumber: phoneNo,
        dateJoin: DateTime.now().toString(),
        username: username,
        email: email,
        password: password,
        bio: bio,
        follower: [],
        following: [],
        uid: credential.user!.uid,
        posts: [],
        savePosts: [],
        archiveposts: [],
        acLocation: '',
        name: '',
        photoUrl: noimg,
      );
      final decodedJsonObj = data.toJson();
      await docUser.set(decodedJsonObj);
    } catch (e) {
      log('=====!!!!!=$e=!!!!!!======');
    }
  }

  Future<String> addProfilePic({required Uint8List file, uid}) async {
    try {
      if (file.isNotEmpty) {
        final docUser =
            FirebaseFirestore.instance.collection('user').doc(gUid ?? uid);
        log('Uid----$gUid');
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        docUser.update({'photoUrl': photoUrl});
        log('Photo Url -----$photoUrl');
        return photoUrl;
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
    return '';
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (e) {
        log(e.toString());
        return false;
      }
      log('user can login success');
      return true;
    }
  }

  Future<void> logout() async {
    name.dispose();
    editeusername.dispose();
    newusername.dispose();
    bio.dispose();
    newname.dispose();
    newbio.dispose();
    await _auth.signOut();
  }

/*---------------------------------------------update-----------------------------------*/

  Future<bool> updateName({required String name, uid}) async {
    try {
      if (name.isNotEmpty) {
        final docUser =
            FirebaseFirestore.instance.collection('user').doc(gUid ?? uid);
        docUser.update({'name': name});
        return true;
      } else {
        log('empty name');
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> updateUsername({required String username, uid}) async {
    try {
      if (username.isNotEmpty) {
        final docUser =
            FirebaseFirestore.instance.collection('user').doc(gUid ?? uid);
        docUser.update({'username': username});
        return true;
      } else {
        log('empty username');
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> updateBio({required String bio, uid}) async {
    try {
      if (bio.isNotEmpty) {
        final docUser =
            FirebaseFirestore.instance.collection('user').doc(gUid ?? uid);
        docUser.update({'bio': bio});
        return true;
      } else {
        log('empty bio');
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> updatepots({required String postuid, uid}) async {
    try {
      if (postuid.isNotEmpty) {
        final docUser =
            FirebaseFirestore.instance.collection('user').doc(gUid ?? uid);
        docUser.update({
          'posts': FieldValue.arrayUnion([postuid])
        });
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> updateSavepots({
    required String uid,
    required String postId,
  }) async {
    bool isOk = false;

    try {
      if (currentuserdata!.savePosts.contains(postId)) {
        _firestore.collection('user').doc(uid).update({
          'savePosts': FieldValue.arrayRemove([postId])
        });
        isOk = false;
      } else {
        _firestore.collection('user').doc(uid).update({
          'savePosts': FieldValue.arrayUnion([postId])
        });
        isOk = true;
      }
    } catch (e) {
      isOk = false;
    }

    return isOk;
  }
  
  Future<bool> updateArchivePost({
    required String uid,
    required String postId,
  }) async {
    bool isOk = false;

    try {
      if (currentuserdata!.savePosts.contains(postId)) {
        _firestore.collection('user').doc(uid).update({
          'archiveposts': FieldValue.arrayRemove([postId])
        });
        isOk = false;
      } else {
        _firestore.collection('user').doc(uid).update({
          'archiveposts': FieldValue.arrayUnion([postId])
        });
        isOk = true;
      }
    } catch (e) {
      isOk = false;
    }

    return isOk;
  }
}
