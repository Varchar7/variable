import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/post_image.dart';

class FirebaseDatabaseCollection {
  static CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  static CollectionReference solutionsCollectionReference =
      FirebaseFirestore.instance.collection('solutions');

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
    return response;
  }

  static Future createPostDatabase(
    Map<String, dynamic> data,
    Uint8List? images,
  ) async {
    String id = postsCollectionReference.doc().id;
    String url = '';
    if (images != null) {
      url = await PostImageService.uploadPostPicture(postId: id, image: images);
    }
    data.addAll(
      {
        "id": id,
        "images": url,
      },
    );
    postsCollectionReference.doc(id).set(data);
    updateDataOnUserDatabase(
      {
        "posts": FieldValue.arrayUnion([id]),
      },
    );
  }

  static Future deletePostDatabase(String id, bool images) async {
    await postsCollectionReference.doc(id).delete();
    await updateDataOnUserDatabase(
      {
        "posts": FieldValue.arrayRemove([id])
      },
    );
    images ? await PostImageService.deletePostPicture(id) : false;
  }

  static Future<Map<String, dynamic>> selectPostDatabase(String id) async {
    final data = await postsCollectionReference.doc(id).get();
    Map<String, dynamic> response = data.data() as Map<String, dynamic>;

    return response;
  }

  static createSoluton(Map<String, dynamic> data) {
    String id = postsCollectionReference.doc().id;
    data.addAll(
      {
        "id": id,
      },
    );
    solutionsCollectionReference.doc(id).set(data);

    updateDataOnUserDatabase(
      {
        "solutions": FieldValue.arrayUnion([id]),
      },
    );
  }

  static Future deleteSoluton(String id) async {
    await solutionsCollectionReference.doc(id).delete();
    await updateDataOnUserDatabase(
      {
        "solutions": FieldValue.arrayRemove([id])
      },
    );
  }

  static followUser(String id) async {
    String uid = FirebaseAuthenticationService.user.uid;
    await usersCollectionReference.doc(uid).update(
      {
        "followings": FieldValue.arrayUnion([id])
      },
    );
    await usersCollectionReference.doc(id).update(
      {
        "followings": FieldValue.arrayUnion([uid])
      },
    );
  }

  static unFollowUser(String id) async {
    String uid = FirebaseAuthenticationService.user.uid;
    await usersCollectionReference.doc(uid).update(
      {
        "followings": FieldValue.arrayRemove([id])
      },
    );
    await usersCollectionReference.doc(id).update(
      {
        "followings": FieldValue.arrayRemove([uid])
      },
    );
  }

    static addFavouriteList(String id) async {
       String uid = FirebaseAuthenticationService.user.uid;
    await usersCollectionReference.doc(uid).update(
      {
        "followings": FieldValue.arrayRemove([id])
      },
    );
  }
}
