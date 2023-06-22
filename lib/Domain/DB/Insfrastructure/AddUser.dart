import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/StorageMethods.dart';
import 'package:instagram_clone/Domain/DB/Model/Usermodel.dart';

String? G_uid;

//create a classs for signUp user [with firebase]
class AuthMethod {
  //Intialise auth & firestore
  //for register app
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //for add data to firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//get user details for stateManagement
  Future<UserData> getUserDetail() async {
    User? currentUser = _auth.currentUser;
    DocumentSnapshot snapshot = await _firestore
        .collection('user')
        .doc(currentUser!.uid)
        .get(); //get current user's data
    return UserData.fromSnap(snapshot);
  }

  //Method for signUp user
  Future<void> signUp({
    required String email,
    required String password,
    required String PhNo,
    required String username,
    required String bio,
    required bool istory,
  }) async {
    //Register App
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      G_uid = cred.user!.uid;
      final docUser = _firestore.collection('user').doc(cred.user!.uid);
      final data = UserData(
          highLight: false,
          PhoneNumber: PhNo,
          IsStory: istory,
          username: username,
          email: email,
          password: password,
          bio: bio,
          follower: [],
          following: [],
          uid: cred.user!.uid);
      final decodJsonObj = data.tojson();
      await docUser.set(decodJsonObj);
    } catch (e) {
      log('=====!!!!!=$e=!!!!!!======');
    }
  }

  Future<String> addProfilePic({required Uint8List file, uid}) async {
    try {
      if (file.isNotEmpty) {
        final docuser =
            FirebaseFirestore.instance.collection('user').doc(G_uid ?? uid);
        log('Uid----$G_uid');
        String photoUrl = await storageMethords()
            .uploadImageToStorage('profilePics', file, false);
        docuser.update({'photoUrl': photoUrl});
        log('Photo Url -----$photoUrl');
        return photoUrl;
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
    return '';
  }

  Future<void> updateName({required String name, uid}) async {
    try {
      if (name.isNotEmpty) {
        final docuser =
            FirebaseFirestore.instance.collection('user').doc(G_uid ?? uid);

        docuser.update({'name': name});
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUsername({required String username, uid}) async {
    try {
      if (username.isNotEmpty) {
        final docuser =
            FirebaseFirestore.instance.collection('user').doc(G_uid ?? uid);

        docuser.update({'username': username});
      }
    } catch (e) {
      log(e.toString());
    }
    return;
  }
  Future<void> updateBio({required String bio, uid}) async {
    try {
      if (bio.isNotEmpty) {
        final docuser =
            FirebaseFirestore.instance.collection('user').doc(G_uid ?? uid);

        docuser.update({'bio': bio});
      }
    } catch (e) {
      log(e.toString());
    }
    return;
  }

  Future<bool> loginUser(
      {required String Email, required String Password}) async {
    if (Email.isEmpty || Password.isEmpty) {
      return false;
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: Email, password: Password);
      } catch (e) {
        log(e.toString());
        return false;
      }
      log('user can login sucess');
      return true;
    }
  }

  Future<void> Logout() async {
    await _auth.signOut();
  }
}
