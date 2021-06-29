import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FBStorage {
  static Future<String?> uploadPostImages(
      {@required String? postID, @required File? postImageFile}) async {
    try {
      String fileName = 'images/$postID/postImage';
      FirebaseStorage storage = FirebaseStorage.instance;
      String? postImageURL;
      Reference ref = storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(postImageFile!);
      TaskSnapshot? takeSnapshot;
      uploadTask.whenComplete(() {
        postImageURL = takeSnapshot!.ref.getDownloadURL() as String;
      }).catchError((onError) {
        print(onError);
      });
      return postImageURL;
    } catch (e) {
      print(e);
    }
  }
}
