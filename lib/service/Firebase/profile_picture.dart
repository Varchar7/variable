import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:variable/service/Firebase/auth.dart';

import 'curd_user_database.dart';

class UserProfilePicture {
  static uploadProfilePicture(Uint8List image) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("images")
        .child("profile")
        .child(FirebaseAuthenticationService.user.uid)
        .putData(image);

    final url = await taskSnapshot.ref.getDownloadURL();
    FirebaseDatabaseCollection.updateDataOnUserDatabase(
      {
        "image": url,
      },
    );
  }

  static Future<void> deleteProfilePicture() async {
    await FirebaseDatabaseCollection.updateDataOnUserDatabase(
      {
        "image": "",
      },
    );
    await FirebaseStorage.instance
        .ref()
        .child("images")
        .child("profile")
        .child(FirebaseAuthenticationService.user.uid)
        .delete();
  }
}
