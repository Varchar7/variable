import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

class PostImageService {
  static Future<String> uploadPostPicture(
      {required String postId,
      required Uint8List image,
      required int index}) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("images")
        .child("posts")
        .child(postId)
        .child('$index')
        .putData(image);

    final url = await taskSnapshot.ref.getDownloadURL();
    FirebaseDatabaseCollection.updateDataOnUserDatabase(
      {
        "image": url,
      },
    );
    return url;
  }
}
