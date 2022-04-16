import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/post_image.dart';

class FirebaseDatabaseCollection {
  static CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  static Future createUserDatabase() async {
    usersCollectionReference.doc(FirebaseAuthenticationService.user.uid);
  }

  static Future createDataOnUserDatabase(Map<String, dynamic> data) async {
    usersCollectionReference
        .doc(FirebaseAuthenticationService.user.uid)
        .set(data);
  }

  static updateDataOnUserDatabase(Map<String, dynamic> data) async {
    usersCollectionReference
        .doc(FirebaseAuthenticationService.user.uid)
        .update(data);
  }

  static Future<Map<String, dynamic>> selectDataOnUserDatabase() async {
    final data = await usersCollectionReference
        .doc(FirebaseAuthenticationService.user.uid)
        .get();
    Map<String, dynamic> response = data.data() as Map<String, dynamic>;
    print(response["account"].runtimeType);
    return response;
  }

  static Future createPostDatabase(
    Map<String, dynamic> data,
    List<Uint8List> images,
  ) async {
    List<String> imagesURL = [];
    String id = postsCollectionReference.doc().id;
    for (var i = 0; i < images.length; i++) {
      final url = await PostImageService.uploadPostPicture(
          postId: id, image: images[i], index: i);
      imagesURL.add(url);
    }
    data.addAll(
      {
        "id": id,
        "images": imagesURL,
      },
    );
    postsCollectionReference.doc(id).set(data);
    updateDataOnUserDatabase(
      {
        "posts": FieldValue.arrayUnion([id]),
      },
    );
  }

  static Future deletePostDatabase(String id) async {
    postsCollectionReference.doc(id).delete();
    updateDataOnUserDatabase(
      {
        "account": {
          "posts": FieldValue.arrayRemove([id])
        }
      },
    );
  }

  static Future<Map<String, dynamic>> selectPostDatabase(String id) async {
    final data = await postsCollectionReference.doc(id).get();
    Map<String, dynamic> response = data.data() as Map<String, dynamic>;

    return response;
  }
}
