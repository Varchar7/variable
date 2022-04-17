import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

class UsersServices {
  static Stream<DocumentSnapshot<Object?>> getUser(String uid) {
    return FirebaseDatabaseCollection.usersCollectionReference
        .doc(uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getUsersPost() {
    return FirebaseDatabaseCollection.postsCollectionReference
        .where("uid", isEqualTo: FirebaseAuthenticationService.user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getAllPost() {
    return FirebaseDatabaseCollection.postsCollectionReference.snapshots();
  }
}
