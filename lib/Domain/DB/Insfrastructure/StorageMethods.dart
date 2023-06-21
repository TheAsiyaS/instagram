
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class storageMethords {
  final FirebaseStorage store = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool ispass) async {
    //Register app
    Reference ref = store.ref().child(childName).child(_auth.currentUser!.uid);
    if (ispass) {
      String id = const Uuid().v1();
      ref = ref.child(id);  
    }
    //upload image to firebase
    UploadTask task = ref.putData(file);
    //take data
    TaskSnapshot snap = await task;
    //data to firebase
    String DownloadURL = await snap.ref.getDownloadURL();
    return DownloadURL;
  }
}
