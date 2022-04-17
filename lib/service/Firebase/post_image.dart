import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class PostImageService {
  static Future<String> uploadPostPicture({
    required String postId,
    required Uint8List image,
  }) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("images")
        .child("posts")
        .child(postId)
        .putData(image);

    final url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  static Future<void> deletePostPicture(String postId) async {
    FirebaseStorage.instance
        .ref()
        .child("images")
        .child("posts")
        .child(postId)
        .delete();
  }
}
