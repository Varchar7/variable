import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

class UsersServices {
  static Future<Map<String, dynamic>> getUser(String uid) async {
    final data = await FirebaseDatabaseCollection.usersCollectionReference
        .doc(uid)
        .get();
    return data.data() as Map<String, dynamic>;
  }

  static Stream<QuerySnapshot<Object?>> getUsersPost() {
    return FirebaseDatabaseCollection.postsCollectionReference
        .where("uid", isEqualTo: FirebaseAuthenticationService.user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getOtherUsersPost(String id) {
    return FirebaseDatabaseCollection.postsCollectionReference
        .where("uid", isEqualTo: id)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getAllPost() {
    return FirebaseDatabaseCollection.postsCollectionReference.snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getUsers() {
    return FirebaseDatabaseCollection.usersCollectionReference.snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getSoluions(String postID) {
    return FirebaseDatabaseCollection.solutionsCollectionReference
        .where("postID", isEqualTo: postID)
        .snapshots();
  }
}
